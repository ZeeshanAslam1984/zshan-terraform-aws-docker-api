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
from django.views.generic.base import RedirectView

from core import views as core_views


urlpatterns = [
    # FIX: Add a homepage route to redirect to the API docs
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
    path('api/recipe/', include('recipe.urls')), # Line 36: Trailing whitespace removed here
]

# This block serves static/media files only in development mode (DEBUG=True).
# In production (ECS/Fargate), Nginx handles this.
if settings.DEBUG:
    urlpatterns += static(
        settings.MEDIA_URL,
        document_root=settings.MEDIA_ROOT,
    )
    urlpatterns += static(
        settings.STATIC_URL,
        document_root=settings.STATIC_ROOT,
    )
