close all; clear; clc;
t = linspace(0, 1, 100);
a = sin(2*pi*t);
b = sin(2*pi*t+pi/3);
figure; plot(t, a, 'r', t, b, 'k');
legend('a', 'b');
amb = ones(100,1)*1e6;
for ia = 1:length(a)
    for ib = 1:length(b)
        currentDist = sqrt((a(ia)-b(ib))^2 + (ia-ib)^2);
        if currentDist < amb(ia)
            amb(ia) = currentDist;
        end
    end
end
%D = sum(amb);
%Dist = sqrt(dtw(a,b));
ED = sqrt(sum((a-b).^2));

[Dist, D, k, w, rw, tw] = dtw2(a,b,1);
LW = length(rw);
tw_norm=(0:LW-1)/LW;
figure; plot(tw_norm, rw, 'b');
hold on; plot(t, a, 'r');
hold off;