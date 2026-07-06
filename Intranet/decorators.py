from django.contrib.auth.decorators import login_required
from django.shortcuts import render, redirect
from functools import wraps
from urllib.parse import urlencode
from functools import wraps
from django.contrib.auth.models import User
from django.template.response import TemplateResponse

def role_required(roles):
    def decorator(view_func):
        @wraps(view_func)
        def wrapper(request, *args, **kwargs):

            if not request.user.is_authenticated:
                q = urlencode({"required": "forbidden"})
                return redirect(f"/login/?{q}")

            user_roles = request.user.groups.values_list("name", flat=True)

            if not any(r in user_roles for r in roles):
                q = urlencode({"required": "no_permission"})
                return redirect(f"/login/?{q}")

            return view_func(request, *args, **kwargs)

        return wrapper
    return decorator
