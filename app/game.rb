require "app/duck"
require "app/water"
require "app/camera"
require "app/background"
require "app/bathtube"

class Game
    attr_gtk

    def tick
        defaults
        calc
        render
    end

    def defaults
        state.world.w ||= 10000
        state.world.h ||= grid.h

        state.duck ||= Duck.new(args, x: 1000, y: state.world.h * 0.9)
        state.water ||= Water.new(args, h: state.world.h * 0.50)
        state.camera ||= Camera.new(args, x: state.duck.x, y: state.duck.y, zoom: 1)
        state.background ||= Background.new(args, x:0, y: 300)
        state.bathtube ||= Bathtube.new(args, x: 0, y: 0, w: state.world.w, h: 900)
    end

    def calc
        state.duck.calc

        follow_x = state.duck.x + state.duck.w / 2
        follow_y = state.duck.y + state.duck.h / 2
        state.camera.calc(x:follow_x, y: follow_y)
        state.background.calc
    end

    def render

        # FPS
        args.outputs.labels << { x: 30, y: 30.from_top, text: "FPS #{args.gtk.current_framerate.to_sf}" }

        state.camera.render_in_world  [
            state.background,
            state.bathtube,
            state.duck,
            state.water
        ]
    end
end
