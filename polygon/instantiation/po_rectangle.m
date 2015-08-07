function rectangle = po_rectangle(center, lengths, tilt, number_of_edges, resolution)
%po_rectangle: instantiation of a closed polygon sampling a rectangle
%   p = po_rectangle(c, l, t, n, s) computes a closed polygon sampling the
%   rectangle of center c, lengths l, and tilt angle t with either n regularly
%   spaced vertices (or equivalently n edges) or a vertex every s pixels.
%   Resolution s is used unless n is strictly greater than 3. s does not have to
%   be an integer. If n is strictly greater than 3, then it must be equal to
%   2*(i+j) for some integers i and j.
%   l can be a 1x2 or a 2x1 matrix. t is in degrees.
%
%See also polygon.
%
%Polygon Toolbox by Eric Debreuve
%Last update: June 13, 2006

if number_of_edges > 3
   resolution = 2 * sum(lengths) / number_of_edges;
end

half_lengths = lengths / 2;
lengths = round(lengths / resolution);

if any(lengths <= 0)
   rectangle = [];
   return
end

horizontal_side = resolution * (lengths(2):-1:0) - half_lengths(2);
horizontal_side(1) = half_lengths(2);
vertical_side = resolution * (lengths(1)-1:-1:1) - half_lengths(1);

rectangle = [vertical_side, zeros(1,lengths(2) + 1) - half_lengths(1), ...
             fliplr(vertical_side), half_lengths(1) * ones(1,lengths(2) + 1); ...
             half_lengths(2) * ones(1, lengths(1) - 1), horizontal_side, ...
             zeros(1, lengths(1) - 1) - half_lengths(2), fliplr(horizontal_side); ...
             ones(1, 2 * sum(lengths))];

tilt = tilt * pi / 180;
cos_of_tilt = cos(tilt);
sin_of_tilt = sin(tilt);

in_place = [cos_of_tilt, - sin_of_tilt, center(1); ...
            sin_of_tilt,   cos_of_tilt, center(2)];
rectangle = in_place * rectangle;

rectangle = [rectangle(:,end) rectangle];
