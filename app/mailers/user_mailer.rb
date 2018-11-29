class UserMailer < ApplicationMailer

	def group_invite(email)
		mail(to: email, subject: 'You have been invited to join a group on CHRONO!')
	end

end
