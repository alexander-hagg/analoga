function [qualitaet,wieVieleRichtig] = orakel(blob,elefant)

schwarzRichtig =    sum( blob(:) == 0 & elefant(:) == 0 );
weissRichtig   =    sum( blob(:) == 1 & elefant(:) == 1 );

wieVieleRichtig = schwarzRichtig + weissRichtig;

qualitaet = schwarzRichtig./sum(elefant(:) == 0) + weissRichtig./sum(elefant(:) == 1);

qualitaet = qualitaet * 50;

%qualitaet = (wieVieleRichtig)/(size(blob,1)*size(blob,2));
%qualitaet = 100*max(0,qualitaet);

end