from random import choice

def run(trials=3000):

	coin = ['heads', 'tails']
	payouts = []

	payout = lambda x: 2**x

	for i in range(trials):
		this_flip = 'heads'
		num_heads = 0

		while this_flip == 'heads':
			if choice(coin) == 'heads':
				num_heads += 1
			else:
				this_flip = 'tails'

		this_payout = payout(num_heads)
		payouts.append(this_payout)

	
	total = 0
	for i in payouts:
		total += i

	avg = total / len(payouts)

	return avg
	

if __name__ == '__main__':
	print(run())
