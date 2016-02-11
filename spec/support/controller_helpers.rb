module ControllerHelpers
  def sign_in(args = nil)
    session[:user_id] = setup_user(args).id
  end

  private

  def setup_user(args)
    case args
    when User
      args
    when Hash
      factory = args.delete(:factory) || :user
      create(factory, args)
    when Symbol
      create(args)
    else
      create(:user)
    end
  end
end
