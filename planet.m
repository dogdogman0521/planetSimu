classdef planet
    properties (Constant)
        G = 6.67*10^(-11);
        dt=0.005;
    end
    properties
        mass
        pos
        velocity
        name
        status='a';
    end
    methods
        function obj = planet(mass, pos, velocity, name)
            obj.mass = mass;
            obj.pos = pos;
            obj.velocity = velocity;
            obj.name = name;
        end
    end
end



