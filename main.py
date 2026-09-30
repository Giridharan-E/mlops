from fastapi import FastAPI
from pydantic import BaseModel, Field

app = FastAPI(title="MLOps Prediction API")


class PredictionRequest(BaseModel):
    features: list[float] = Field(min_length=1)


@app.get("/health")
def health() -> dict[str, str]:
    return {"status": "healthy"}


@app.post("/predict")
def predict(request: PredictionRequest) -> dict[str, float]:
    return {"prediction": sum(request.features)}