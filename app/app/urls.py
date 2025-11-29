"""app URL Configuration

The `urlpatterns` list routes URLs to views.
"""
from drf_spectacular.views import (
    SpectacularAPIView,
    SpectacularSwaggerView,
)

from django.contrib import admin
from django.urls import path, include
from django.conf.urls.static import static
from django.conf import settings
# ADDED: Import RedirectView
from django.views.generic.base import RedirectView

from core import views as core_views


urlpatterns = [
    # ADDED: This path redirects the root URL to the API docs
    path('', RedirectView.as_view(url='/api/docs/'), name='home'),

    path('admin/', admin.site.urls),
    path('api/health-check/', core_views.health_check, name='health-check'),
    path('api/schema/', SpectacularAPIView.as_view(), name='api-schema'),
    path(
        'api/docs/',
        SpectacularSwaggerView.as_view(url_name='api-schema'),
        name='api-docs',
    ),
    path('api/user/', include('user.urls')),
    path('api/recipe/', include('recipe.urls')),
]

# This configuration allows static/media files to be served 
# by Django directly when you are running in Development mode (DEBUG=True).
# In Production (ECS), Nginx handles this.
if settings.DEBUG:
    urlpatterns += static(
        settings.MEDIA_URL,
        document_root=settings.MEDIA_ROOT,
    )
    # It is also good practice to add STATIC support here for local dev
    urlpatterns += static(
        settings.STATIC_URL,
        document_root=settings.STATIC_ROOT,
    )
