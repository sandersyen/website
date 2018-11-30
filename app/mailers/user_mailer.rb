class UserMailer < ApplicationMailer

	def event_invite(email)
		mail(to: email, subject: 'You have been invited to join an event on CHRONO!')
	end

	def group_invite(email)
		mail(to: email, subject: 'You have been invited to join a group on CHRONO!')
	end

end
