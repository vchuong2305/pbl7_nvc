from pydantic_settings import BaseSettings
import os

class Settings(BaseSettings):
    # Database - use Railway's PostgreSQL in production
    DATABASE_URL: str = os.getenv("DATABASE_URL", "sqlite:///./weather.db")

    # Model paths
    MODEL_PATH: str = os.getenv("MODEL_PATH", "models/best_model.h5")
    SCALER_PATH: str = os.getenv("SCALER_PATH", "models/scaler_strong_fluctuation.pkl")

    # API Keys
    API_KEY: str = os.getenv("API_KEY", "your_api_key")
    OPENWEATHER_API_KEY: str = os.getenv("OPENWEATHER_API_KEY", "5d254dd6acc8d4ff0f338e2d3256f013")

    # Application settings
    DEBUG: bool = os.getenv("DEBUG", "False").lower() == "true"

    class Config:
        env_file = ".env"

settings = Settings() 