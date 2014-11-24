from django.conf.urls import patterns, include, url
from django.contrib import admin

# For oAuth

from django.contrib.auth.models import User, Group
admin.autodiscover()

from rest_framework import viewsets, routers
from rest_framework import permissions

from oauth2_provider.ext.rest_framework import TokenHasReadWriteScope, TokenHasScope
from oauth2_provider.views.mixins import ScopedResourceMixin


# ViewSets define the view behavior.
class UserViewSet(viewsets.ModelViewSet):
    permission_classes = [permissions.IsAuthenticated, TokenHasReadWriteScope]
    model = User


class GroupViewSet(ScopedResourceMixin, viewsets.ModelViewSet):
    permission_classes = [permissions.IsAuthenticated, TokenHasScope]
    required_scopes = ['groups']
    model = Group


# Routers provide an easy way of automatically determining the URL conf
router = routers.DefaultRouter()
router.register(r'users', UserViewSet)
router.register(r'groups', GroupViewSet)




urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'ben_grimm.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),


    # For oAuth
    url(r'^', include(router.urls)),
    url(r'^login', include('oauth2_provider.urls')),

    url(r'^admin/', include(admin.site.urls)),
)
