FROM tatemz/wp-cli

ARG USER_ID
# ARG GROUP_ID

# RUN addgroup --gid $GROUP_ID user
# RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid 33 user

USER user