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
S = (1/6)(average polarity) + (1/180)(60 - average time difference) + (1/6)(percent messages + percent content)
  average polarity = a sentiment analysis gives us a number between -1 and 1 for the polarity of the text messages. Adding one to it and     dividing by two gives us only positive numbers.
  average time difference = the time it takes for the other individual to respond, in minutes. Subtracting it from 60 and then dividing it   by 60 gives us a number between 0 and 1. 
  percent messages = the percent of the total messages sent by the responder
  percent content = the percent of the total content sent by the responder
Se = expected Suave = 1 / ((10^(-ds/400))+1)
ds = difference in suave score between the two candidates

The equation is designed such that Se will be some number between 0 and 1, as will S. 

Probabilities: 
The equation follows the probabilities of the English Premiere League in the link below. 
http://www.eloratings.net/system.html
