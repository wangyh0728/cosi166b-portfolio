
class MovieData
	attr_accessor :reviews_hash
	attr_accessor :movie_users_list
	attr_accessor :test_set
	attr_accessor :user_similarity
	attr_accessor :prediction_result

	def initialize(filepath, filename = nil)
		@reviews_hash = {}
		@movie_users_list = {}
		@test_set = []
		@user_similarity = {}
		@prediction_result = []

		test_file_name = ""
		training_file_name = ""
		if filename.nil? 
			training_file_name = filepath + "/u.data"
		else 
			training_file_name = filepath + "/" + filename.to_s + ".base"
			test_file_name = filepath + "/" + filename.to_s + ".test"
		end
		txt = open(training_file_name)
		txt.each_line do |x| 
			split = x.split("\t").map{|x| x.to_i}
			#movie_users_list: {"movie1" => [[user1,rating1], [user2,rating2]], "movie2" => ...}
			movie_id = split[1]
			user_id = split[0]
			if movie_users_list[movie_id].nil?
				movie_users_list[movie_id] = []
			end
			movie_users_list[movie_id] = movie_users_list[movie_id].push([user_id, split[2]])
			#push all reviews to reviews_hash as user_id is the key
			#review_hash = {"user1" => [[movie1,rating1,time1], [movie2,rating2,time2]], "user2" => ...}
			if reviews_hash[user_id].nil?
				reviews_hash[user_id] = []
			end
			reviews_hash[user_id] = reviews_hash[user_id].push(split[1..3])
		end
		#load test data
		txt = open(test_file_name)
		txt.each_line do |x| 
			test_set.push(x.split("\t").map{|x| x.to_i})
		end
	end

    # rating(u,m) - returns the rating that user u gave movie m in the training set, 
    # and 0 if user u did not rate movie m
    def rating(user_id, movie_id) 
    	movie_list = reviews_hash[user_id.to_i]
    	if movie_list.nil?
    		puts "No such user"
    		exit(0)
    	end
    	movie_list = movie_list.transpose

    	index = movie_list[0].index(movie_id.to_i)

    	if index.nil?
    		return 0
    	else
    		return movie_list[1][index]
    	end
    end
    


    # predict(u,m) - returns a floating point number between 1.0 and 5.0 
    # as an estimate of what user u would rate movie m
    # for each movie m, find all viewers u' and calculate similarity(u, u')*rating(u',m)
    def predict_2(user_id, movie_id)
    	count = 0;
    	if user_similarity[user_id.to_i].nil?
    		user_similarity[user_id.to_i] = most_similar(user_id.to_i)
    	end
    	rating = 0.0
    	#user_similarity: {"user1"=>{"user2"=>similarity, "user3" => similarity}, "user2"....}
    	user_similarity[user_id.to_i].each do |u,s|
    		
    		if (tmp = rating(u.to_i,movie_id.to_i)) != 0
    			count += 1
    		end
    		rating += (tmp * 1.0 * s).round(4)
    	end
    	# if(rating / count).to_s == "NaN"
    	# 	puts user_id, movie_id
    	# 	puts
    	# end
    	if count == 0 
    		return 0.0 
    	end
    	return (rating/count).round(4)
    end



    # movies(u) - returns the array of movies that user u has watched
    def movies(user_id)
    	begin 
    		return reviews_hash[user_id.to_i].transpose[0]
    	rescue
    		puts "No such user"
    		exit(0)
    	end
    end



    # viewers(m) - returns the array of users that have seen movie m
    def viewers(movie_id)
    	begin 
    		return movie_users_list[movie_id.to_i].transpose[0]
    	rescue
    		puts "No such movie"
    		exit(0)
    	end
    end

    # z.to_a returns an array of the predictions in the form [u,m,r,p]. 
    # You can also generate other types of error measures if you want, but we will rely mostly on the root mean square error.
    def to_a()
    	return prediction_result
    end


    # run_test(k) - runs the z.predict method on the first k ratings in the test set 
    # and returns a MovieTest object containing the results.
    #  The parameter k is optional and if omitted, all of the tests will be run.
    def run_test(k = nil)
    	if test_set.empty?
    		return nil
    	end
    	predict_result = []
    	if k.nil?
    		k = test_set.size
    	end
    	(0..k-1).each do |i|
    		predict_result.push(predict_2(test_set[i][0],test_set[i][1]))
    	end
    	tmp = test_set.transpose
    	test = MovieTest.new(tmp[2][0..k-1],predict_result)
    	#add results to prediction_result: [u,m,r,p]
    	prediction_result.push(tmp[0][0..k-1])
    	prediction_result.push(tmp[1][0..k-1])
    	prediction_result.push(tmp[2][0..k-1])
    	prediction_result.push(predict_result)
    	@prediction_result = @prediction_result.transpose

    end

	#similarity(user1,user2) - this will generate a number which indicates the similarity in movie 
	#preference between user1 and user2 (where higher numbers indicate greater similarity)
	def similarity(user1, user2) 
		simil = 0.0;
		user1_movie_list = reviews_hash[user1.to_i].transpose
		user2_movie_list = reviews_hash[user2.to_i].transpose
		movie_in_common = user1_movie_list[0] & user2_movie_list[0]

		if movie_in_common.empty?
			return 0.0
		end
		movie_in_common.each do |x|
			#find index of the common movie/ratings
			index1 = user1_movie_list[0].index(x)
			index2 = user2_movie_list[0].index(x)
			simil1 = user1_movie_list[1][index1]
			simil2 = user2_movie_list[1][index2]
			simil += (5-(simil1.to_i - simil2.to_i).abs)/5.0
		end
		return (simil/movie_in_common.size).round(2)
	end

	#most_similar(u) - this return a list of users whose tastes are most similar to the tastes of user u
	#only return the top ten similar users
	def most_similar(u)
		mSimilar= {}
		reviews_hash.each do |user, moveis|	
			if (s = similarity(u,user)) >= 0.8
				mSimilar[user] = s
			end #find the similarity with every other user
		# m = mSimilar.sort_by {|a,b| b}.reverse.transpose[0] #sort according to similarities and then choose the first ten (exclude itself)
		#  return m#[1..10]
		end
		return mSimilar
	end
end

class MovieTest
	attr_accessor :error_list

	def initialize(test_data, predict_data)
		@error_list = []
		if test_data.size == predict_data.size
			(0..test_data.size-1).each do |i|
    		error_list.push((test_data[i] - predict_data[i]).abs)
    	end
		else 
			puts "unmatched number of test_data and predict_data"
			exit(0)
		end
	end

    # t.mean returns the average predication error (which should be close to zero)
    def mean() 
    	return error_list.inject{|s,n| s + n}/(error_list.size * 1.0)
    end

    # t.stddev returns the standard deviation of the error
    def stddev()
    	return Math.sqrt(self.var())
    end

    def var()
    	m = self.mean()
    	return error_list.inject{|s,n| s + (n-m) * (n-m)}/(error_list.size - 1)
    end


    # t.rms returns the root mean square error of the prediction
    def rms()
    	r = error_list.inject{|s,n| s + n ** 2}/error_list.size
    	return Math.sqrt(r)
    end

end



z = MovieData.new("ml-100k", :ua)
# (1..100).each do |i|
# 	puts z.predict(1,i)
# end
#puts z.predict_2(2,314)
 z.run_test()
# puts z.most_similar(2)
#puts z.similarity(1,34)


# u1: 0.5840662685647888 [Finished in 345.6s]
