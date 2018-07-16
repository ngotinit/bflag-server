module Admin::SessionsHelper
  def log_in(admin)
    cookies.encrypted[:id] = admin.id
  end

  def log_out
    cookies.delete(:id)
    @current_admin = nil
  end

  def current_admin
    @current_admin ||= Admin.find_by(id: cookies.encrypted[:id])
  end

  def admin_logged_in?
    current_admin.present?
  end

  def require_admin_log_in
    redirect_to admin_login_path unless admin_logged_in?
  end
end
