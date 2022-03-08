require "test_helper"

class NotifierTest < ActionMailer::TestCase
  def test_admin_user_reset_password
    admin_user = FactoryBot.create(:admin_user, email: "admin@email.com")
    admin_user.perishable_token = "PERISHABLE-TOKEN"

    email = Notifier.admin_user_reset_password(admin_user).deliver_now
    assert !ActionMailer::Base.deliveries.empty?

    assert_equal ["it@theultimatesciencefictionawardwinningbooksinternetdatabase.com"], email.from
    assert_equal ["admin@email.com"], email.to
    assert_equal "[TheUltimateScienceFictionAwardWinningBooksInternetDatabase] Password reset", email.subject

    # write_fixture("/notifier/admin_user_reset_password.txt", email.body.encoded)
    assert_equal(File.read(fixture("/notifier/admin_user_reset_password.txt")), email.body.encoded)
  end

  def test_front_user_reset_password
    front_user = FactoryBot.create(:front_user, email: "front@email.com")
    front_user.perishable_token = "PERISHABLE-TOKEN"

    email = Notifier.front_user_reset_password(front_user).deliver_now
    assert !ActionMailer::Base.deliveries.empty?

    assert_equal ["it@theultimatesciencefictionawardwinningbooksinternetdatabase.com"], email.from
    assert_equal ["front@email.com"], email.to
    assert_equal "[TheUltimateScienceFictionAwardWinningBooksInternetDatabase] Password reset", email.subject

    # write_fixture("/notifier/front_user_reset_password.txt", email.body.encoded)
    assert_equal(File.read(fixture("/notifier/front_user_reset_password.txt")), email.body.encoded)
  end

  def test_simple_test_email
    email = Notifier.simple_test_email("Wadus", "wadus@example.com").deliver_now
    assert !ActionMailer::Base.deliveries.empty?

    assert_equal ["it@theultimatesciencefictionawardwinningbooksinternetdatabase.com"], email.from
    assert_equal ["wadus@example.com"], email.to
    assert_equal "[TheUltimateScienceFictionAwardWinningBooksInternetDatabase] Wadus", email.subject

    # write_fixture("/notifier/simple_test_email.txt", email.body.encoded)
    assert_equal(File.read(fixture("/notifier/simple_test_email.txt")), email.body.encoded)
  end
end
