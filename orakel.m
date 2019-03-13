function [qualitaet,wieVieleRichtig] = orakel(blob,elefant)

schwarzRichtig =    sum( blob(:) == 0 & elefant(:) == 0 );
weissRichtig   =    sum( blob(:) == 1 & elefant(:) == 1 );

wieVieleRichtig = schwarzRichtig + weissRichtig;

qualitaet = (wieVieleRichtig-1400)/(size(blob,1)*size(blob,2));
qualitaet = 100*max(0,qualitaet);

end