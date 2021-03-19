class FriendsController < ApplicationController
    def create
        @friend = Friend.new
        @friend_user = User.find(params[:friend_id])
        @friend.friend_id = @friend_user.id
        @friend.user_id = current_user.id

        if @friend.save
            flash[:alert] = "Friend was added"
            redirect_to user_profile_path(@friend_user)
          else
            flash[:alert] = 'Something happened, try again'
            redirect_to user_profile_path(@friend_user)
          end
    end

    def destroy
        @friend_user = User.find(params[:id])
        @friend = Friend.where(user_id: current_user.id, friend_id: params[:id]).first
        if @friend.destroy
            flash[:alert] = 'Friend was deleted'
            redirect_to user_profile_path(@friend_user)
        else
            flash[:alert] = 'This friendship was not for you'
            redirect_to user_profile_path(@friend_user)
        end
    end
end
