function planets = claclulateTrackAcc(planets)
    G = planets(1).G;
    dt = planets(1).dt;
    pos = [planets(:).pos];
    mass = [planets(:).mass];
    velocity = [planets(:).velocity];
    velocity = transpose(reshape(velocity,[3 size(planets,2)]));
    pos = transpose(reshape(pos,[3 size(planets,2)]));
    combs = nchoosek(1:size(planets,2),2);
    c1=combs(:,1);
    c2=combs(:,2);
    r = pos(c2,:)-pos(c1,:);
    r_val = vecnorm(r,2,2);
    for i=1:size(r,1)
        if r_val(i) < 1e+6
            m = planets(c1(i)).mass + planets(c2(i)).mass;
            p = (planets(c1(i)).pos + planets(c2(i)).pos)./2;
            v = (planets(c1(i)).mass .* planets(c1(i)).velocity + planets(c2(i)).mass .* planets(c2(i)).velocity) ./ m;
            mergePlanet = planet(m,p,v,[planets(c1(i)).name '+' planets(c2(i)).name]);
            planets([c1(i),c2(i)]) = [];
            planets = [planets mergePlanet];
            return
        end
    end
    ind = [1:size(r,1)];
    f_val = G .* mass(c1) .* mass(c2) ./ transpose(r_val(ind));
    f_dir = r(ind)./transpose(r_val(ind));
    f_val_dir = f_val .*f_dir;
    fullMatrix = repmat(f_val_dir(1:size(planets,2)-1),size(planets,2),1)*-1;
    n = 1;
    for i = 1:size(planets,2)
        fullMatrix(i,i:end) = f_val_dir(n:n+size(planets,2)-i-1);
        n = n + size(planets,2)-i;
    end
    a = sum(fullMatrix,2)./transpose(mass);
    velocity = velocity + a * dt;
    pos = pos + velocity*dt + 0.5 * a * dt^2;
    for i = 1:size(planets,2)
        planets(i).pos = pos(i,:);
        planets(i).velocity = velocity(i,:);
    end

end

