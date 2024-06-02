require_relative 'minitestw'

class SampleTest < Minitestw::Test
  def setup
    @user = User.new('Kasa', 'kasa@rubyconftw2023.com')
  end

  def test_name_with_email
    assert_equal correct_name_with_email, @user.name_with_email
  end

  def test_this_fails
    assert @user.name.nil?
    assert @user.email.nil?
  end

  private

  def correct_name_with_email
    'Kasa <kasa@rubyconftw2023.com>'
  end
end

class User
  attr_accessor :name, :email

  def initialize(name, email)
    @name = name
    @email = email
  end

  def name_with_email
    "#{name} <#{email}>"
  end
end
