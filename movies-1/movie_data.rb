
class MovieData
	attr_accessor :reviews_hash
	attr_accessor :movie_popularity_hash

	def initialize
		@reviews_hash = {}
		@movie_popularity_hash = {}
	end

	#load-data: this will read in the data from the original ml-100k files and 
	#stores them in whichever way it needs to be stored
	def load_data(filename)
		txt = open(filename)
		txt.each_line do |x| 
			split = x.split("\t")
			#count popularity
			movie_id = split[1].to_i
			if movie_popularity_hash[movie_id].nil?
				movie_popularity_hash[movie_id] = 1
			else movie_popularity_hash[movie_id] = movie_popularity_hash[movie_id] + 1
			end
			#push all reviews to reviews_hash as user_id is the key
			#review_hash = {"user1" => [[movie1,rating1,time1], [movie2,rating2,time2]], "user2" => ...}
			user_id = split[0].to_i
			if reviews_hash[user_id].nil?
				reviews_hash[user_id] = []
			end
			reviews_hash[user_id] = reviews_hash[user_id].push(split[1..3])
		end

		
	end


	#popularity(movie_id) - this will return a number that indicates the popularity 
	#(higher numbers are more popular). You should be prepared to explain the reasoning 
	#behind your definition of popularity
	def popularity(movie_id)
		return movie_popularity_hash[movie_id]
	end	

	#popularity_list - this will generate a list of all movie_id’s ordered by decreasing popularity
	def popularity_list()
		m = movie_popularity_hash.sort_by {|a,b| b}.reverse
		m = m.transpose #m[0] is movie_id and m[1] is its popularity
		return m[0]
	end

	#similarity(user1,user2) - this will generate a number which indicates the similarity in movie 
	#preference between user1 and user2 (where higher numbers indicate greater similarity)
	def similarity(user1, user2) 
		simil = 0;
		user1_movie_list = reviews_hash[user1.to_i].transpose
		user2_movie_list = reviews_hash[user2.to_i].transpose
		movie_in_common = user1_movie_list[0] & user2_movie_list[0]
		movie_in_common.each do |x|
			#find index of the common movie/ratings
			index1 = user1_movie_list[0].index(x)
			index2 = user2_movie_list[0].index(x)
			simil1 = user1_movie_list[1][index1]
			simil2 = user2_movie_list[1][index2]
			simil += 1.0/((simil1.to_i - simil2.to_i).abs + 1) # 1/(rating difference + 1)
		end
		return simil.round(2)
	end
	#most_similar(u) - this return a list of users whose tastes are most similar to the tastes of user u
	#only return the top ten similar users
	def most_similar(u)
		mSimilar= {}
		reviews_hash.each {|user, moveis|	mSimilar[user] = similarity(u,user)} #find the similarity with every other user
		m = mSimilar.sort_by {|a,b| b}.reverse.transpose[0] #sort according to similarities and then choose the first ten (exclude itself)
		return m[1..10]
	end
end

m = MovieData.new
m.load_data("u.data")
#print m.movie_popularity_hash
#puts m.reviews_hash
#print m.popularity(100)
popul = m.popularity_list()
puts "The first ten elements of the popularity list are: "
(0..9).each {|i| puts popul[i]}
puts "The last ten elements of the popularity list are: "
(-10..-1).each {|i| puts popul[i]}
#puts m.similarity(13,1)
puts "The most similar users of user_1 are: "
puts m.most_similar(1)