
clc;clear;close;
f = figure('name','行星運動');
axis equal
grid on 
hold on
view(3)
xlabel('x')
ylabel('y')
zlabel('z')
hold on


for i = 1:100
    planets(i) = planet(rand()*10^6,[rand()*10^5,rand()*10^5,rand()*10^5],[rand()*1000,rand()*1000,rand()*1000],num2str(i));
end

frame = 1;
while true

    planets = claclulateTrackAcc(planets);
    frame = frame +1;
    if mod(frame,1)==0
        for i = 1:size(planets,2)
            scatter3(planets(i).pos(1),planets(i).pos(2),planets(i).pos(3),'filled','b');
            text(planets(i).pos(1),planets(i).pos(2),planets(i).pos(3),planets(i).name);
            hold on
        end
        set(gcf, 'InvertHardCopy', 'off');
        set(gcf,'Color',[0 0 0]);
        name = sprintf('%05d', frame);
        saveas(gcf, ['.\output\' name '.png'])
        close
    end
    if size(planets,2) == 1
        break
    end
end

