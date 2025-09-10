from flask import Flask, jsonify, request
import os
import redis
import psycopg2
from dotenv import load_dotenv

load_dotenv()

app = Flask(__name__)

# Database connection
def get_db_connection():
    try:
        conn = psycopg2.connect(
            host=os.getenv('DB_HOST', 'postgres'),
            database=os.getenv('DB_NAME', 'multiapp'),
            user=os.getenv('DB_USER', 'dev'),
            password=os.getenv('DB_PASSWORD', 'devpass')
        )
        return conn
    except Exception as e:
        print(f"Database connection error: {e}")
        return None

# Redis connection
def get_redis_connection():
    try:
        r = redis.Redis(
            host=os.getenv('REDIS_HOST', 'redis'),
            port=int(os.getenv('REDIS_PORT', 6379)),
            decode_responses=True
        )
        return r
    except Exception as e:
        print(f"Redis connection error: {e}")
        return None

@app.route('/')
def hello():
    return jsonify({
        'message': 'Hello from Python Flask API!',
        'language': 'Python',
        'framework': 'Flask',
        'version': '3.11'
    })

@app.route('/health')
def health():
    # Check database connection
    db_status = 'healthy'
    try:
        conn = get_db_connection()
        if conn:
            conn.close()
        else:
            db_status = 'unhealthy'
    except:
        db_status = 'unhealthy'
    
    # Check Redis connection
    redis_status = 'healthy'
    try:
        r = get_redis_connection()
        if r:
            r.ping()
        else:
            redis_status = 'unhealthy'
    except:
        redis_status = 'unhealthy'
    
    return jsonify({
        'status': 'healthy',
        'database': db_status,
        'redis': redis_status,
        'service': 'python-api'
    })

@app.route('/api/users', methods=['GET', 'POST'])
def users():
    if request.method == 'GET':
        # Mock data for demonstration
        return jsonify({
            'users': [
                {'id': 1, 'name': 'John Doe', 'email': 'john@example.com'},
                {'id': 2, 'name': 'Jane Smith', 'email': 'jane@example.com'}
            ]
        })
    
    elif request.method == 'POST':
        data = request.get_json()
        # In a real app, you would save to database
        return jsonify({
            'message': 'User created successfully',
            'user': data
        }), 201

@app.route('/api/cache/<key>')
def get_cache(key):
    r = get_redis_connection()
    if r:
        value = r.get(key)
        if value:
            return jsonify({'key': key, 'value': value})
        else:
            return jsonify({'error': 'Key not found'}), 404
    else:
        return jsonify({'error': 'Redis connection failed'}), 500

@app.route('/api/cache/<key>/<value>', methods=['POST'])
def set_cache(key, value):
    r = get_redis_connection()
    if r:
        r.set(key, value, ex=3600)  # Expire in 1 hour
        return jsonify({'message': 'Cache set successfully', 'key': key, 'value': value})
    else:
        return jsonify({'error': 'Redis connection failed'}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)