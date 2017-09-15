class MessagesController < ApplicationController

  def index
    @group = Group.find(params[:group_id])
    @groups = current_user.groups
    @message = Message.new
    @messages = Message.where(group_id: params[:group_id])
  end

  def create
    @group = Group.find(params[:group_id])
    @message = Message.new(messages_params)
    if @message.save
      redirect_to group_messages_path, notice: "メッセージが投稿されました。"
    else
      redirect_to group_messages_path, alert: "投稿内容が空欄です。"
    end
  end
  private
  def messages_params
    params.require(:message).permit(:msg, :image).merge(user_id: current_user.id, group_id: params[:group_id])
  end
end
