#!/usr/bin/env python3
#! -*- coding:utf-8 -*-
"""
  # ParrotSec_invite_key
"""
import base64
from flask import request, render_template, abort

from config import app


def enc_to_b64(str_encrypt):
    base64_encrypt = base64.b64encode(str_encrypt.encode('utf-8'))
    return str(base64_encrypt,'utf-8')


@app.route("/invite", methods=["POST", "GET"])
def invite_key():
    if request.method == "POST":
        if request.args.get('key') or request.args.get('add'):
            key_txt = request.args.get('key')
            add_txt = request.args.get('add')
            if key_txt == "ParrotSec" and add_txt == "qq_group":
                if request.form.get("code") == "动次打次":
                    return render_template("invite.html", post_key=True, pwd="动次打次", value="key{parrot_1s_pirates_friend}")
            return render_template("invite.html", post_key=False)
        else:
            abort(500)
    else:
        if request.args.get('key') or request.args.get('add'):
            key_txt = request.args.get('key')
            add_txt = request.args.get('add')
            if key_txt == "ParrotSec" and add_txt == "qq_group":
                return render_template("invite.html", get_key=True, pwd="动次打次")
            elif key_txt == '""' and add_txt == '""':
                value1 = dict(key=enc_to_b64("ParrotSec"))
                value2 = dict(add=enc_to_b64("qq_group"))
                return render_template("invite.html", value1=value1, value2=value2)
            else:
                pass
            return render_template("invite.html", get_key=False)
        else:
            return render_template("invite.html", get_key=False)


@app.errorhandler(404)
def page_not_find(e):
    return render_template('404.html'), 404


if __name__ == '__main__':
    app.run(host="0.0.0.0",port=4568)
