
Code Climate: https://codeclimate.com/repos/54cda4b2e30ba06c940002f1/feed

Github: https://github.com/wangyh0728/cosi166b-movies2.git

Algorithm: For predict(u,m), firstly find the most similar users of u and their corresponding similarities. Then the predicted rating of user u towards movie m is the sum of the similarity(u,u') times with rating(u',m), divided by the number of the most similar users. Since users who have higher similarities will have more possibility give the same rating to the same movie, thus I used the user similarity as weights. And it is easier to implement. Besides, I cached users' similarities in order to reduce running time. The disadvantage are that the running efficiency is low when calculating similarities and the predictions are not accurate enough.

Analysis(average): Error Mean: 0.9, Stddev: 0.6, rsm:1.12. As k gets larger, an and rsm go  up and stddev goes down.

BenchMarking: Running time per prediction is around 0.02s. Expect logarithm time increase as training set size increasing.