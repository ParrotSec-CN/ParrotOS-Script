## ParrotSec-invite

> Install package

- `apt -y install python3.5-dev python3-dev uwsgi uwsgi-plugin-python uwsgi-plugin-python3 pip3`

- `pip3 install uwsgi`

- `cp /usr/lib/uwsgi/plugins/python3x_plugin.so ./`

> Start Python Program

- `python run_invite.py`

- **or**

- `uwsgi --plugins python35 --http-socket :4568 -M -w run_invite:app`
