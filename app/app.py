import os
import redis

from flask import Flask
from flask import request, redirect, render_template, url_for
from flask import Response

app = Flask(__name__)
app.debug = True
redis_host=os.getenv('REDIS_PORT_6379_TCP_ADDR', '127.0.0.1')
redis_port=int(os.getenv('REDIS_PORT_6379_TCP_PORT', '6379'))
app.redis = redis.StrictRedis(host=redis_host, port=redis_port, db=0)

@app.route('/', methods=['GET', 'POST'])
def main_page():
    if request.method == 'POST':
        app.redis.lpush('entries', request.form['entry'])
        return redirect(url_for('main_page'))
    else:
        entries = app.redis.lrange('entries', 0, -1)
        return render_template('main.html', entries=entries)

@app.route('/clear', methods=['POST'])
def clear_entries():
    app.redis.ltrim('entries', 1, 0)
    return redirect(url_for('main_page'))

if __name__ == "__main__":
  app.run(host='0.0.0.0', port=80)
