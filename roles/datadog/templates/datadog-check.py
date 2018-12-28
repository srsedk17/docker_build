#!/usr/bin/env python

from base import BaseCheck


class Check(BaseCheck):

    def check(self, **kwargs):
        self.systemd_unit_is_running('datadog.service')
        self.container_is_running('datadog')