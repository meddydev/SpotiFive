User.destroy_all
Game.destroy_all

User.create(email: "ahmed@test.com", name: "Ahmed Hall", image_url: "https://scontent-ams4-1.xx.fbcdn.net/v/t1.6435-1/36737951_2092011394348455_807664592808312832_n.jpg?stp=c0.0.320.320a_dst-jpg_p320x320&_nc_cat=104&ccb=1-7&_nc_sid=0c64ff&_nc_ohc=mPpqrpZhRdIAX_JBr5c&_nc_ht=scontent-ams4-1.xx&edm=AP4hL3IEAAAA&oh=00_AT_7KpM4-3C5dSatPf20Qzd-sNwHu1dTMiHFR0UWgzO8zQ&oe=63348D1B", total_score: 10, num_games: 1, auth_token: "auth1", refresh_token: "refresh1")
Game.create(user_id: 1, artist_id: "1234", artist_name: "Rihanna", score: 10, )