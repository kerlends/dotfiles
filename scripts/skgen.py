import string
import random

CHARS = ''.join(
    [string.ascii_letters,
     string.digits,
     string.punctuation])\
    .replace('\'', '')\
    .replace('""', '')\
    .replace('\\', '')

sk = ''.join([random.SystemRandom().choice(CHARS) for i in range(50)])

print(sk)
