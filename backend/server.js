const express = require('express');
const cors = require('cors');
const http = require('http');
const WebSocket = require('ws');
const { marketDataController } = require('./controllers/marketDataController');
const { analyticsController } = require('./controllers/analyticsController');
const { portfolioController } = require('./controllers/portfolioController');
const { errorHandler } = require('./middlewares/errorHandler');
const { requestLogger } = require('./middlewares/requestLogger');
const { rateLimiter } = require('./middlewares/rateLimiter');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());
app.use(requestLogger);
app.use(rateLimiter);

// Routes
app.use('/api/market-data', marketDataController);
app.use('/api/analytics', analyticsController);
app.use('/api/portfolio', portfolioController);

// Health check
app.get('/health', (req, res) => {
  res.json({ status: 'ok', timestamp: new Date().toISOString() });
});

// Error handling
app.use(errorHandler);

// Create HTTP server
const server = http.createServer(app);

// WebSocket server for real-time updates
const wss = new WebSocket.Server({ server });
const { mockMarketData } = require('./data/mockMarketData');

// Base prices for each symbol (for realistic price variations)
const basePrices = {
  'BTC/USD': 43250.50,
  'ETH/USD': 2650.75,
  'SOL/USD': 98.25,
  'ADA/USD': 0.52,
  'DOT/USD': 7.85
};

const baseChanges = {
  'BTC/USD': 2.5,
  'ETH/USD': -1.2,
  'SOL/USD': 5.3,
  'ADA/USD': 1.8,
  'DOT/USD': -0.5
};

wss.on('connection', (ws) => {
  console.log('WebSocket client connected');
  
  // Send initial market data for all symbols
  const symbols = ['BTC/USD', 'ETH/USD', 'SOL/USD', 'ADA/USD', 'DOT/USD'];
  symbols.forEach((symbol) => {
    const basePrice = basePrices[symbol];
    const baseChange = baseChanges[symbol];
    const initialData = {
      type: 'market_update',
      data: {
        symbol: symbol,
        price: parseFloat((basePrice * (1 + (Math.random() - 0.5) * 0.001)).toFixed(2)),
        change24h: parseFloat((baseChange + (Math.random() - 0.5) * 0.2).toFixed(2)),
        volume: Math.floor(1250000000 * (0.5 + Math.random())),
        timestamp: new Date().toISOString()
      }
    };
    ws.send(JSON.stringify(initialData));
  });

  // Simulate real-time updates every 2 seconds for all symbols
  const interval = setInterval(() => {
    if (ws.readyState === WebSocket.OPEN) {
      symbols.forEach((symbol) => {
        const basePrice = basePrices[symbol];
        const baseChange = baseChanges[symbol];
        
        // Generate realistic price variation (±1%)
        const priceVariation = (Math.random() - 0.5) * 0.02;
        const newPrice = basePrice * (1 + priceVariation);
        
        // Generate realistic change variation
        const changeVariation = (Math.random() - 0.5) * 0.2;
        const newChange = baseChange + changeVariation;
        
        const update = {
          type: 'market_update',
          data: {
            symbol: symbol,
            price: parseFloat(newPrice.toFixed(2)),
            change24h: parseFloat(newChange.toFixed(2)),
            changePercent24h: parseFloat(newChange.toFixed(2)),
            volume: Math.floor(1250000000 * (0.5 + Math.random())),
            timestamp: new Date().toISOString()
          }
        };
        
        ws.send(JSON.stringify(update));
      });
    }
  }, 2000);

  ws.on('close', () => {
    console.log('WebSocket client disconnected');
    clearInterval(interval);
  });

  ws.on('error', (error) => {
    console.error('WebSocket error:', error);
    clearInterval(interval);
  });
});

server.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
  console.log(`WebSocket server ready on ws://localhost:${PORT}`);
});
