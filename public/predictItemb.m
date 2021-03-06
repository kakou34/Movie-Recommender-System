function [prediction] = predictItemb(user, item, matrix)

%finding similarities 
similarity = zeros(1682,2);
for i=1:1682
    %check only for movies that the user rated
    if(matrix(user,i)~=0 && i ~= item)
      similarity(i,2) = cosineSimAdj(matrix, item, i);
      similarity(i,1) = matrix(user,i);
    else
        similarity(i,2) = NaN;
    end
end

similarity = sortrows(similarity,2,'descend','MissingPlacement','last');

% finding k nearest items 
nearest_items = similarity(1:20,:);

for i=1:20
    if (isnan(nearest_items(i,2)) || nearest_items(i,2)<0)
        nearest_items(i,2) = 0;
    end
end

up = dot(nearest_items(:,1),nearest_items(:,2));
down = sum(nearest_items(:,2));

prediction = up/down;


if(prediction < 1)
    prediction = 1;
end

if(prediction > 5)
    prediction = 5;
end

end

