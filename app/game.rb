require "app/duck"
require "app/water"
require "app/camera"
require "app/background"

class Game
    attr_gtk

    def tick
        defaults
        calc
        render
    end

    def defaults
        state.world.w ||= 3500
        state.world.h ||= 2000

        state.duck ||= Duck.new(args, x: 1000, y: state.world.h * 0.54)
        state.water ||= Water.new(args, h: state.world.h * 0.60)
        state.camera ||= Camera.new(args, x: state.duck.x, y: state.duck.y, scale: 0.85)
        state.background ||= Background.new(args)
    end

    def calc
        state.duck.calc

        camera_x = state.duck.x + state.duck.w / 2
        camera_y = state.duck.y + state.duck.h / 2
        #camera_x = state.duck.x
        #camera_y = state.duck.y
        state.camera.calc(camera_x, camera_y)
        state.background.calc
    end

    def render
        outputs.solids << {x: 0, y:0, w: grid.w, h: grid.h, r: 200, g: 200, b: 200}

        # scene
        outputs[:scene].transient!
        outputs[:scene].w = state.world.w
        outputs[:scene].h = state.world.h

        state.background.render

        state.duck.render
        state.water.render

        state.camera.render
    end

    def render_background
        
    end
end