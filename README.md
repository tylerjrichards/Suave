# Suave
Internally at Tinder there is a rating equation modeled after the system created by Arpad Elo. In the most basic sense, the system is designed to predict the success of the interaction from the difference between the two scores, and compare that to the actual success. For Tinder's application, a success would be a right swipe, and a failure would be a left swipe.  
There is one issue however, and this is the general issue with using an Elo rating system, which is it fails to take into account anything after a match happens.
Note: all of this is assumed from research about Elo systems as Tinder (rightfully) does not release their algorithm to the public

This R package is another rating system that could be used by Tinder to illustrate how smooth individuals were once the match happened. The math is described below. 

The general formula is as follows:
R2 = R0 + K(S - Se)
where
R2 = New Suave Rank
R0 = Old Suave Rank
K = 30
S = (1/6)(average polarity + 1) + (1/180)(60 - average time difference) + (1/6)(percent messages + percent content)
  average polarity = a sentiment analysis gives us a number between -1 and 1 for the polarity of the text messages. Adding one to it and     dividing by two gives us only positive numbers.
  average time difference = the time it takes for the other individual to respond, in minutes. Subtracting it from 60 and then dividing it   by 60 gives us a number between 0 and 1. 
  percent messages = the percent of the total messages sent by the responder
  percent content = the percent of the total content sent by the responder
Se = expected Suave = 1 / ((10^(-ds/400))+1)
ds = difference in suave score between the two candidates

The equation is designed such that Se will be some number between 0 and 1, as will S. 

Probabilities: 


Difference in Ratings	 Higher Rated	 Lower Rated
0	  0.500	0.500
10	0.514	0.486
20	0.529	0.471
30	0.543	0.457
40	0.557	0.443
50	0.571	0.429
60	0.585	0.415
70	0.599	0.401
80	0.613	0.387
90	0.627	0.373
100	0.640	0.360
110	0.653	0.347
120	0.666	0.334
130	0.679	0.321
140	0.691	0.309
150	0.703	0.297
160	0.715	0.285
170	0.727	0.273
180	0.738	0.262
190	0.749	0.251
200	0.760	0.240
210	0.770	0.230
220	0.780	0.220
230	0.790	0.210
240	0.799	0.201
250	0.808	0.192
260	0.817	0.183
270	0.826	0.174
280	0.834	0.166
290	0.841	0.159
300	0.849	0.151
325	0.867	0.133
350	0.882	0.118
375	0.896	0.104
400	0.909	0.091
425	0.920	0.080
450	0.930	0.070
475	0.939	0.061
500	0.947	0.053
525	0.954	0.046
550	0.960	0.040
575	0.965	0.035
600	0.969	0.031
625	0.973	0.027
650	0.977	0.023
675	0.980	0.020
700	0.983	0.017
725	0.985	0.015
750	0.987	0.013
775	0.989	0.011
800	0.990	0.010
