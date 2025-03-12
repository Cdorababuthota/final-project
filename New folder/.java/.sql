-- Users table
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email TEXT UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- User preferences table
CREATE TABLE user_preferences (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    topics TEXT[], -- e.g., ["technology", "sports"]
    keywords TEXT[], -- e.g., ["AI", "blockchain"]
    preferred_sources TEXT[], -- e.g., ["BBC", "TechCrunch"]
    created_at TIMESTAMP DEFAULT NOW()
);

-- Raw news articles table
CREATE TABLE raw_articles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title TEXT NOT NULL,
    content TEXT NOT NULL,
    source TEXT NOT NULL,
    url TEXT NOT NULL,
    published_at TIMESTAMP,
    fetched_at TIMESTAMP DEFAULT NOW()
);

-- Processed articles table
CREATE TABLE processed_articles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    raw_article_id UUID REFERENCES raw_articles(id) ON DELETE CASCADE,
    summary TEXT NOT NULL,
    sentiment_label TEXT NOT NULL, -- e.g., "positive", "negative", "neutral"
    sentiment_explanation TEXT,
    processed_at TIMESTAMP DEFAULT NOW()
);

-- User interactions table
CREATE TABLE user_interactions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    article_id UUID REFERENCES processed_articles(id) ON DELETE CASCADE,
    is_read BOOLEAN DEFAULT FALSE,
    is_saved BOOLEAN DEFAULT FALSE,
    shared_at TIMESTAMP
);