const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const { Pool } = require('pg');
const redis = require('redis');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(helmet());
app.use(cors());
app.use(express.json());

// Database connection
const pool = new Pool({
  host: process.env.DB_HOST || 'postgres',
  port: process.env.DB_PORT || 5432,
  database: process.env.DB_NAME || 'multiapp',
  user: process.env.DB_USER || 'dev',
  password: process.env.DB_PASSWORD || 'devpass',
});

// Redis connection
const redisClient = redis.createClient({
  host: process.env.REDIS_HOST || 'redis',
  port: process.env.REDIS_PORT || 6379,
});

redisClient.on('error', (err) => {
  console.error('Redis connection error:', err);
});

redisClient.connect().catch(console.error);

// Routes
app.get('/', (req, res) => {
  res.json({
    message: 'Hello from Node.js Express API!',
    language: 'JavaScript',
    runtime: 'Node.js',
    framework: 'Express',
    version: process.version
  });
});

app.get('/health', async (req, res) => {
  let dbStatus = 'healthy';
  let redisStatus = 'healthy';

  // Check database connection
  try {
    await pool.query('SELECT NOW()');
  } catch (error) {
    console.error('Database health check failed:', error);
    dbStatus = 'unhealthy';
  }

  // Check Redis connection
  try {
    await redisClient.ping();
  } catch (error) {
    console.error('Redis health check failed:', error);
    redisStatus = 'unhealthy';
  }

  res.json({
    status: 'healthy',
    database: dbStatus,
    redis: redisStatus,
    service: 'nodejs-api',
    timestamp: new Date().toISOString()
  });
});

app.get('/api/products', async (req, res) => {
  try {
    // Mock data for demonstration
    const products = [
      { id: 1, name: 'Laptop', price: 999.99, category: 'Electronics' },
      { id: 2, name: 'Book', price: 29.99, category: 'Education' },
      { id: 3, name: 'Coffee Mug', price: 12.99, category: 'Kitchen' }
    ];

    res.json({
      products,
      total: products.length
    });
  } catch (error) {
    console.error('Error fetching products:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

app.post('/api/products', async (req, res) => {
  try {
    const { name, price, category } = req.body;
    
    if (!name || !price || !category) {
      return res.status(400).json({ error: 'Missing required fields' });
    }

    // In a real app, you would save to database
    const newProduct = {
      id: Date.now(),
      name,
      price: parseFloat(price),
      category,
      createdAt: new Date().toISOString()
    };

    res.status(201).json({
      message: 'Product created successfully',
      product: newProduct
    });
  } catch (error) {
    console.error('Error creating product:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

app.get('/api/cache/:key', async (req, res) => {
  try {
    const { key } = req.params;
    const value = await redisClient.get(key);
    
    if (value) {
      res.json({ key, value });
    } else {
      res.status(404).json({ error: 'Key not found' });
    }
  } catch (error) {
    console.error('Redis get error:', error);
    res.status(500).json({ error: 'Redis operation failed' });
  }
});

app.post('/api/cache/:key/:value', async (req, res) => {
  try {
    const { key, value } = req.params;
    await redisClient.setEx(key, 3600, value); // Expire in 1 hour
    
    res.json({
      message: 'Cache set successfully',
      key,
      value
    });
  } catch (error) {
    console.error('Redis set error:', error);
    res.status(500).json({ error: 'Redis operation failed' });
  }
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: 'Something went wrong!' });
});

// 404 handler
app.use('*', (req, res) => {
  res.status(404).json({ error: 'Route not found' });
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Node.js API server running on port ${PORT}`);
});