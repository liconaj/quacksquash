PRIMARY_KEYS = [:j, :z, :space]
SECONDARY_KEYS = [:k, :x, :backspace]

def primary_down?(inputs)
    PRIMARY_KEYS.any? { |k| inputs.keyboard.key_down.send(k) } ||
        inputs.controller_one.key_down&.a
end

def up?(inputs)
    args.inputs.up
end

def down?(inputs)
    args.inputs.down
end