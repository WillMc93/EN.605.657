import numpy as np

def bern(prob=0.5, max_N=4, after_max=17):
    probs = [prob**n for n in range(1, max_N+2)]
    probs.append(1 - np.sum(probs))

    payoffs = [2**n for n in range(0, max_N+1)]
    payoffs.append(17)
    
    assert(len(probs) == len(payoffs))
    
    expect = np.sum(np.multiply(probs, payoffs))
    
    print(probs, payoffs)
    
    return expect


def wtf(max_N=4):
    choices = ['H', 'T']
    
    results = []
    
    for i in range(int(250e3)+1):
        result = 0
        
        if not i % 1000:
            print(f"Trial {i}")
        
        while np.random.choice(choices, p=[0.35, 1-0.35]) != 'T':
            result += 1
            
        results.append(result)
        
    temp = [n for n in range(0, max_N+2)]
    tally = {}
    for t in temp:
        tally[t] = 0
    
    for result in results:
        if result <= max_N:
            tally[result] += 1
        else:
            tally[max_N+1] += 1
            
    return tally


def payout(tally):
    s = 0
    trials = 0
    
    for n, t in tally.items():
        if n < 5:
            s += 2**n * t
        else:
            s += 17 * t
            
        trials += t
        
    return s / trials
        
    
if __name__ == '__main__':
    print(bern())
    print(bern(prob=0.35))
    
    tally = wtf()
    print(tally)
    
    print(payout(tally))
    