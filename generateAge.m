%{
function age = generateAge()


age = 0;
diceroll = 20;
%Lookup table for age group to map to random number generated above,

lookupAge = [4 6.3; 9 12.7; 14 18.7; 19 24.8; 24 31.5; 29 38.6; 34 45.9; 39 52.6; 44 59.4; 49 66.2; 54 72.7; 59 78.9; 64 84.5; 69 89.6; 74 93.4; 79 96.2; 84 98.2; 85 100];

%Maps diceroll to age group
for i = 1:18
    if diceroll < lookupAge(i,2) && ;
        age = lookupAge(i-1);
        break
    end
end


end

%}