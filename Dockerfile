FROM public.ecr.aws/lambda/python:3.8

# Install the function's dependencies using file requirements.txt
# from your project folder.

# RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y

FROM ubuntu

# Install the function's dependencies using file requirements.txt
# from your project folder.

# Set the working directory to /app

RUN apt-get update
RUN apt-get install -y python3-opencv
RUN apt install -y python3-pip
RUN pip3 install opencv-python

COPY requirements.txt  .
RUN  pip3 install -r requirements.txt --target "${LAMBDA_TASK_ROOT}"

# Copy function code
COPY app.py ${LAMBDA_TASK_ROOT}
COPY __pycache__ ${LAMBDA_TASK_ROOT}
COPY static ${LAMBDA_TASK_ROOT}
COPY templates ${LAMBDA_TASK_ROOT}
COPY Dockerfile ${LAMBDA_TASK_ROOT}
COPY vishal_model_resnet50.h5 ${LAMBDA_TASK_ROOT}


# Set the CMD to your handler (could also be done as a parameter override outside of the Dockerfile)
CMD [ "app.handler" ]