function h = mov(opc)
% animation_point.m

% Create data
x=opc(:,1);   % Time data
y = opc(:,2); % Position data

% Draw initial figure
figure(2);
set(gcf,'Renderer','OpenGL'); 
h = plot(x(1),y(1),'o','MarkerSize',20,'MarkerFaceColor','b');
set(h,'EraseMode','normal');
xlim([min(x),max(x)]);
ylim([min(y),max(y)]);

% Animation Loop
i = 1;
while i<=length(x)
    set(h,'XData',x(i));
    set(h,'YData',y(i));
    drawnow;
    i = i+1;
end
end