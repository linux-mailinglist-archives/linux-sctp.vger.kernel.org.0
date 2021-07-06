Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7163BC870
	for <lists+linux-sctp@lfdr.de>; Tue,  6 Jul 2021 11:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhGFJY0 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 6 Jul 2021 05:24:26 -0400
Received: from mx-out-01.fh-muenster.de ([185.149.214.63]:57626 "EHLO
        mx-out-01.fh-muenster.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbhGFJYZ (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 6 Jul 2021 05:24:25 -0400
X-Greylist: delayed 461 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Jul 2021 05:24:25 EDT
Received: from mail-director-01.fh-muenster.de (mail-director-01.fh-muenster.de [185.149.215.227])
        by mx-out-01.fh-muenster.de (Postfix) with ESMTPS id AFA3D20A61;
        Tue,  6 Jul 2021 11:13:35 +0200 (CEST)
Received: from fhad-ex04.fhad.fh-muenster.de (fhad-ex04.fhad.fh-muenster.de [10.40.11.27])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-director-01.fh-muenster.de (Postfix) with ESMTPS id 058CF1A022D;
        Tue,  6 Jul 2021 11:13:34 +0200 (CEST)
Received: from fhad-ex04.fhad.fh-muenster.de (10.40.11.27) by
 fhad-ex04.fhad.fh-muenster.de (10.40.11.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 6 Jul 2021 11:12:49 +0200
Received: from fhad-ex04.fhad.fh-muenster.de ([fe80::c97a:37b6:5abe:2799]) by
 fhad-ex04.fhad.fh-muenster.de ([fe80::c97a:37b6:5abe:2799%2]) with mapi id
 15.01.2242.010; Tue, 6 Jul 2021 11:12:49 +0200
From:   =?iso-8859-1?Q?Timo_V=F6lker?= <timo.voelker@fh-muenster.de>
To:     Xin Long <lucien.xin@gmail.com>
CC:     Marcelo Ricardo Leitner <mleitner@redhat.com>,
        "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
        "tuexen@freebsd.org" <tuexen@freebsd.org>
Subject: Re: The new sysctl and socket option added for PLPMTUD (RFC8899)
Thread-Topic: The new sysctl and socket option added for PLPMTUD (RFC8899)
Thread-Index: AQHXX9Hn+sqfrC4B4UWbqq7hmdpKMqs1rQOA
Date:   Tue, 6 Jul 2021 09:12:49 +0000
Message-ID: <C5076473-6E92-4BC9-A034-A887E0A92814@fh-muenster.de>
References: <CADvbK_de_SNVsTmeCUTOVZoD7A9-sB4cAiqv=0rnvgoGfhErOA@mail.gmail.com>
 <FEF068AA-C660-4A25-ABFE-D559B1136B58@fh-muenster.de>
In-Reply-To: <FEF068AA-C660-4A25-ABFE-D559B1136B58@fh-muenster.de>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.40.10.31]
Content-Type: multipart/signed;
        boundary="Apple-Mail=_F651E149-AF95-4090-A327-6294F164A91D";
        protocol="application/pkcs7-signature"; micalg=sha-256
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

--Apple-Mail=_F651E149-AF95-4090-A327-6294F164A91D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


Hi Xin,

I implemented RFC8899 for an SCTP simulation model.

Comments follow inline.

> Begin forwarded message:
>=20
> From: Xin Long <lucien.xin@gmail.com>
> Subject: Re: The new sysctl and socket option added for PLPMTUD =
(RFC8899)
> Date: 12. June 2021 at 19:32:02 CEST
> To: Michael Tuexen <tuexen@freebsd.org>
> Cc: "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>, =
Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
>=20
> On Fri, Jun 11, 2021 at 4:42 PM <tuexen@freebsd.org> wrote:
>>=20
>>> On 11. Jun 2021, at 22:20, Xin Long <lucien.xin@gmail.com> wrote:
>>>=20
>>> Hi, Michael,
>>>=20
>>> In the linux implementation of RFC8899, we decided to introduce one
>>> sysctl and one socket option for users to set up the PLPMUTD probe:
>>>=20
>>> 1. sysctl -w net.sctp.plpmtud_probe_interval=3D1
>>>=20
>>> plpmtud_probe_interval - INTEGER
>>>       The interval (in milliseconds) between PLPMTUD probe chunks. =
These
>>>       chunks are sent at the specified interval with a variable size =
to
>>>       probe the mtu of a given path between 2 associations. PLPMTUD =
will
>> I guess you mean "between 2 end points" instead of "between 2 =
associations".
>>=20
>> I'm not sure what it means:
>>=20
>> I assume, you have candidate 1400, 1420, 1460, 1480, and 1500.
>>=20
>> Assume you sent a probe packet for 1400. Aren't you sending the
>> probe packet for 1420 as soon as you get an ACK for the probe packet
>> of size 1400? Or are you waiting for plpmtud_probe_interval ms?
> It will wait for "plpmtud_probe_interval" ms in searching state, but =
in
> searching complete it will be "plpmtud_probe_interval * 30" ms.

Does this mean you always wait for plpmtud_probe_interval ms? Even if =
you receive an ack for a probe packet or a PTB?

In my implementation, I start with the next probe immediately when =
receiving an ack or PTB.

>=20
> The step we are using is 32, when it fails, we turn the step to 4. For =
example:
> 1400, 1432, 1464, 1496, 1528 (failed), 1500(1496 + 4), 1504(failed,
> 1500 is the PMTU).

What does failed mean? Does it mean that you have sent MAX_PROBES (=3D3?) =
probe packets and waited for each plpmtud_probe_interval ms without =
receiving a response?

If so, it might make sense to continue with smaller candidates earlier. =
For example, after one unanswered probe packet.

>=20
> Sorry, "sysctl -w net.sctp.plpmtud_probe_interval=3D1" won't work.
> As plpmtud_probe_interval is the probe interval TIME for the timer.
> Apart from 0, the minimal value is 5000ms.
>=20
> So it should be:
>=20
> plpmtud_probe_interval - INTEGER
>        The time interval (in milliseconds) for sending PLPMTUD probe =
chunks.
>        These chunks are sent at the specified interval with a variable =
size
>        to probe the mtu of a given path between 2 endpoints. PLPMTUD =
will
>        be disabled when 0 is set.
>=20
>        Default: 0

What do you mean with probe chunks? You are sending probe *packets* =
containing a HEARTBEAT and a PAD chunk, right?

RFC8899 contains:
The PROBE_TIMER is configured to expire after a period longer than the =
maximum time to receive an acknowledgment to a probe packet.

So, how about plpmtud_probe_max_ack_time?

Also, I think more parameters would be helpful. For example,

plpmtud_enable - boolean to control whether to use PLPMTUD (it is more =
explicit than plpmtud_probe_interval=3D0 or =
plpmtud_probe_max_ack_time=3D0)
plpmtud_max_probes - controls the number of probe packets sent for one =
candidate.
plpmtud_raise_time - time to wait before probing for a larger PMTU in =
search complete (0 to disable it).
plpmtud_use_ptb - boolean to control whether to process an ICMP PTB.

Timo

>=20
> Thanks.
>>>       be disabled when 0 is set.
>>>=20
>>>       Default: 0
>>>=20
>>> 2. a socket option that can be used per socket, assoc or transport
>>>=20
>>> /* PLPMTUD Probe Interval socket option */
>>> struct sctp_probeinterval {
>>>       sctp_assoc_t spi_assoc_id;
>>>       struct sockaddr_storage spi_address;
>>>       __u32 spi_interval;
>>> };
>>>=20
>>> #define SCTP_PLPMTUD_PROBE_INTERVAL    133
>>>=20
>>>=20
>>> The value above will enable/disable the PLPMUTD probe by setting up =
the probe
>>> interval for the timer. When it's 0, the timer will also stop and
>>> PLPMUTD is disabled.
>>> By this way, we don't need to introduce more options.
>> OK.
>>>=20
>>> We're expecting to keep consistent with BSD on this, pls check and
>>> share your thoughts.
>> Looks good to me.
>>=20
>> Best regards
>> Michael
>>>=20
>>> Thanks.
>>=20



--Apple-Mail=_F651E149-AF95-4090-A327-6294F164A91D
Content-Disposition: attachment; filename="smime.p7s"
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEK4w
ggUSMIID+qADAgECAgkA4wvV+K8l2YEwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYTAkRFMSsw
KQYDVQQKDCJULVN5c3RlbXMgRW50ZXJwcmlzZSBTZXJ2aWNlcyBHbWJIMR8wHQYDVQQLDBZULVN5
c3RlbXMgVHJ1c3QgQ2VudGVyMSUwIwYDVQQDDBxULVRlbGVTZWMgR2xvYmFsUm9vdCBDbGFzcyAy
MB4XDTE2MDIyMjEzMzgyMloXDTMxMDIyMjIzNTk1OVowgZUxCzAJBgNVBAYTAkRFMUUwQwYDVQQK
EzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMg
ZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNVBAMTJERGTi1WZXJlaW4gQ2VydGlmaWNhdGlv
biBBdXRob3JpdHkgMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMtg1/9moUHN0vqH
l4pzq5lN6mc5WqFggEcVToyVsuXPztNXS43O+FZsFVV2B+pG/cgDRWM+cNSrVICxI5y+NyipCf8F
XRgPxJiZN7Mg9mZ4F4fCnQ7MSjLnFp2uDo0peQcAIFTcFV9Kltd4tjTTwXS1nem/wHdN6r1ZB+Ba
L2w8pQDcNb1lDY9/Mm3yWmpLYgHurDg0WUU2SQXaeMpqbVvAgWsRzNI8qIv4cRrKO+KA3Ra0Z3qL
NupOkSk9s1FcragMvp0049ENF4N1xDkesJQLEvHVaY4l9Lg9K7/AjsMeO6W/VRCrKq4Xl14zzsjz
9AkH4wKGMUZrAcUQDBHHWekCAwEAAaOCAXQwggFwMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQU
k+PYMiba1fFKpZFK4OpL4qIMz+EwHwYDVR0jBBgwFoAUv1kgNgB5oKAia4zV8mHSuCzLgkowEgYD
VR0TAQH/BAgwBgEB/wIBAjAzBgNVHSAELDAqMA8GDSsGAQQBga0hgiwBAQQwDQYLKwYBBAGBrSGC
LB4wCAYGZ4EMAQICMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9wa2kwMzM2LnRlbGVzZWMuZGUv
cmwvVGVsZVNlY19HbG9iYWxSb290X0NsYXNzXzIuY3JsMIGGBggrBgEFBQcBAQR6MHgwLAYIKwYB
BQUHMAGGIGh0dHA6Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL29jc3ByMEgGCCsGAQUFBzAChjxodHRw
Oi8vcGtpMDMzNi50ZWxlc2VjLmRlL2NydC9UZWxlU2VjX0dsb2JhbFJvb3RfQ2xhc3NfMi5jZXIw
DQYJKoZIhvcNAQELBQADggEBAIcL/z4Cm2XIVi3WO5qYi3FP2ropqiH5Ri71sqQPrhE4eTizDnS6
dl2e6BiClmLbTDPo3flq3zK9LExHYFV/53RrtCyD2HlrtrdNUAtmB7Xts5et6u5/MOaZ/SLick0+
hFvu+c+Z6n/XUjkurJgARH5pO7917tALOxrN5fcPImxHhPalR6D90Bo0fa3SPXez7vTXTf/D6OWS
T1k+kEcQSrCFWMBvf/iu7QhCnh7U3xQuTY+8npTD5+32GPg8SecmqKc22CzeIs2LgtjZeOJVEqM7
h0S2EQvVDFKvaYwPBt/QolOLV5h7z/0HJPT8vcP9SpIClxvyt7bPZYoaorVyGTkwggWsMIIElKAD
AgECAgcbY7rQHiw9MA0GCSqGSIb3DQEBCwUAMIGVMQswCQYDVQQGEwJERTFFMEMGA1UEChM8VmVy
ZWluIHp1ciBGb2VyZGVydW5nIGVpbmVzIERldXRzY2hlbiBGb3JzY2h1bmdzbmV0emVzIGUuIFYu
MRAwDgYDVQQLEwdERk4tUEtJMS0wKwYDVQQDEyRERk4tVmVyZWluIENlcnRpZmljYXRpb24gQXV0
aG9yaXR5IDIwHhcNMTYwNTI0MTEzODQwWhcNMzEwMjIyMjM1OTU5WjCBjTELMAkGA1UEBhMCREUx
RTBDBgNVBAoMPFZlcmVpbiB6dXIgRm9lcmRlcnVuZyBlaW5lcyBEZXV0c2NoZW4gRm9yc2NodW5n
c25ldHplcyBlLiBWLjEQMA4GA1UECwwHREZOLVBLSTElMCMGA1UEAwwcREZOLVZlcmVpbiBHbG9i
YWwgSXNzdWluZyBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJ07eRxH3h+Gy8Zp
1xCeOdfZojDbchwFfylfS2jxrRnWTOFrG7ELf6Gr4HuLi9gtzm6IOhDuV+UefwRRNuu6cG1joL6W
LkDh0YNMZj0cZGnlm6Stcq5oOVGHecwX064vXWNxSzl660Knl5BpBb+Q/6RAcL0D57+eGIgfn5mI
TQ5HjUhfZZkQ0tkqSe3BuS0dnxLLFdM/fx5ULzquk1enfnjK1UriGuXtQX1TX8izKvWKMKztFwUk
P7agCwf9TRqaA1KgNpzeJIdl5Of6x5ZzJBTN0OgbaJ4YWa52fvfRCng8h0uwN89Tyjo4EPPLR22M
ZD08WkVKusqAfLjz56dMTM0CAwEAAaOCAgUwggIBMBIGA1UdEwEB/wQIMAYBAf8CAQEwDgYDVR0P
AQH/BAQDAgEGMCkGA1UdIAQiMCAwDQYLKwYBBAGBrSGCLB4wDwYNKwYBBAGBrSGCLAEBBDAdBgNV
HQ4EFgQUazqYi/nyU4na4K2yMh4JH+iqO3QwHwYDVR0jBBgwFoAUk+PYMiba1fFKpZFK4OpL4qIM
z+EwgY8GA1UdHwSBhzCBhDBAoD6gPIY6aHR0cDovL2NkcDEucGNhLmRmbi5kZS9nbG9iYWwtcm9v
dC1nMi1jYS9wdWIvY3JsL2NhY3JsLmNybDBAoD6gPIY6aHR0cDovL2NkcDIucGNhLmRmbi5kZS9n
bG9iYWwtcm9vdC1nMi1jYS9wdWIvY3JsL2NhY3JsLmNybDCB3QYIKwYBBQUHAQEEgdAwgc0wMwYI
KwYBBQUHMAGGJ2h0dHA6Ly9vY3NwLnBjYS5kZm4uZGUvT0NTUC1TZXJ2ZXIvT0NTUDBKBggrBgEF
BQcwAoY+aHR0cDovL2NkcDEucGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1nMi1jYS9wdWIvY2FjZXJ0
L2NhY2VydC5jcnQwSgYIKwYBBQUHMAKGPmh0dHA6Ly9jZHAyLnBjYS5kZm4uZGUvZ2xvYmFsLXJv
b3QtZzItY2EvcHViL2NhY2VydC9jYWNlcnQuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQCBeEWkTqR/
DlXwCbFqPnjMaDWpHPOVnj/z+N9rOHeJLI21rT7H8pTNoAauusyosa0zCLYkhmI2THhuUPDVbmCN
T1IxQ5dGdfBi5G5mUcFCMWdQ5UnnOR7Ln8qGSN4IFP8VSytmm6A4nwDO/afr0X9XLchMX9wQEZc+
lgQCXISoKTlslPwQkgZ7nu7YRrQbtQMMONncsKk/cQYLsgMHM8KNSGMlJTx6e1du94oFOO+4oK4v
9NsH1VuEGMGpuEvObJAaguS5Pfp38dIfMwK/U+d2+dwmJUFvL6Yb+qQTkPp8ftkLYF3sv8pBoGH7
EUkp2KgtdRXYShjqFu9VNCIaE40GMIIF5DCCBMygAwIBAgIMIwapvgoidmnnsEoeMA0GCSqGSIb3
DQEBCwUAMIGNMQswCQYDVQQGEwJERTFFMEMGA1UECgw8VmVyZWluIHp1ciBGb2VyZGVydW5nIGVp
bmVzIERldXRzY2hlbiBGb3JzY2h1bmdzbmV0emVzIGUuIFYuMRAwDgYDVQQLDAdERk4tUEtJMSUw
IwYDVQQDDBxERk4tVmVyZWluIEdsb2JhbCBJc3N1aW5nIENBMB4XDTIwMDYxNTA4MDcxMloXDTIz
MDYxNTA4MDcxMlowejELMAkGA1UEBhMCREUxIDAeBgNVBAoMF0ZhY2hob2Noc2NodWxlIE11ZW5z
dGVyMTIwMAYDVQQLDClGYWNoYmVyZWljaCBFbGVrdHJvdGVjaG5payB1bmQgSW5mb3JtYXRpazEV
MBMGA1UEAwwMVGltbyBWb2Vsa2VyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsRhk
t3rRxBOa5IL86FvAp3iB/hVQ8g9SUGjwjOgYQIxTdxMfJlKSREAWDrkm2NQoUYO/BQ3+tH5/yK+8
pTYdbr6v9akFK/q9Q9I3Rv9NuH/4Y3Qd31mbd73aED4i5aenTgdJYOtk4G1UQOnbY8a1lGba1i5y
2k7gZTNBYyE8GjwQF9RninX1gRRvlK0+RE/+8XGCDYG+iEHhXoTzXnP315Nm+rlpTdP6/18tZIFd
B3Rib1vuEt1vnpS67VayAOqcCFC5JbsOQHrvd0pakvfURSWwoNXY7Chaa2yg20aTjyThQqQQ/l/N
0k3J66RsW8g3Ib7Jj3NNHD7jOkh97spDJQIDAQABo4ICVDCCAlAwPgYDVR0gBDcwNTAPBg0rBgEE
AYGtIYIsAQEEMBAGDisGAQQBga0hgiwBAQQHMBAGDisGAQQBga0hgiwCAQQHMAkGA1UdEwQCMAAw
DgYDVR0PAQH/BAQDAgXgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDAdBgNVHQ4EFgQU
FpjFiguM9kUKX1eL2HNrE5eehXowHwYDVR0jBBgwFoAUazqYi/nyU4na4K2yMh4JH+iqO3QwJgYD
VR0RBB8wHYEbdGltby52b2Vsa2VyQGZoLW11ZW5zdGVyLmRlMIGNBgNVHR8EgYUwgYIwP6A9oDuG
OWh0dHA6Ly9jZHAxLnBjYS5kZm4uZGUvZGZuLWNhLWdsb2JhbC1nMi9wdWIvY3JsL2NhY3JsLmNy
bDA/oD2gO4Y5aHR0cDovL2NkcDIucGNhLmRmbi5kZS9kZm4tY2EtZ2xvYmFsLWcyL3B1Yi9jcmwv
Y2FjcmwuY3JsMIHbBggrBgEFBQcBAQSBzjCByzAzBggrBgEFBQcwAYYnaHR0cDovL29jc3AucGNh
LmRmbi5kZS9PQ1NQLVNlcnZlci9PQ1NQMEkGCCsGAQUFBzAChj1odHRwOi8vY2RwMS5wY2EuZGZu
LmRlL2Rmbi1jYS1nbG9iYWwtZzIvcHViL2NhY2VydC9jYWNlcnQuY3J0MEkGCCsGAQUFBzAChj1o
dHRwOi8vY2RwMi5wY2EuZGZuLmRlL2Rmbi1jYS1nbG9iYWwtZzIvcHViL2NhY2VydC9jYWNlcnQu
Y3J0MA0GCSqGSIb3DQEBCwUAA4IBAQA4nHsyRFfsrgKgWeFhMHS5rrEH35rcng32C6urcvDZ1X/p
qx9FHlKgakKkUbVc8zsr1DbAFVkS+UbdicYFlBeDSF5bgHBHEJoy50Fo+d/keDCsh9/Z5QVjnMIj
Y/7h/E7E35Mv1pO2CE3ZDFmt7G0nrLgtLmuhfg2WQ1lLedkpfF/4HJ9BgpdRS4TDOYFFG124yUJG
KN9UB0iNr7gDVAMDZW4wYiSFdbk+M+p6HMKs1TAkhJygaPyM7QlZZmqx5SRriH0rrXMIoqf7LCfz
goYVOsqeYB6pxuERkuOZdmY0bgumRN39qE7ELrzLf/dCEwbwY3rl1Xj8hhmdURn3V8EMMYIDnTCC
A5kCAQEwgZ4wgY0xCzAJBgNVBAYTAkRFMUUwQwYDVQQKDDxWZXJlaW4genVyIEZvZXJkZXJ1bmcg
ZWluZXMgRGV1dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsMB0RGTi1QS0kx
JTAjBgNVBAMMHERGTi1WZXJlaW4gR2xvYmFsIElzc3VpbmcgQ0ECDCMGqb4KInZp57BKHjANBglg
hkgBZQMEAgEFAKCCAc8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcN
MjEwNzA2MDkxMjQ5WjAvBgkqhkiG9w0BCQQxIgQgYUEt3Ig8R0mcms4eV2l7HTJvKNlV55HfTiC8
cK8Y1Yswga8GCSsGAQQBgjcQBDGBoTCBnjCBjTELMAkGA1UEBhMCREUxRTBDBgNVBAoMPFZlcmVp
biB6dXIgRm9lcmRlcnVuZyBlaW5lcyBEZXV0c2NoZW4gRm9yc2NodW5nc25ldHplcyBlLiBWLjEQ
MA4GA1UECwwHREZOLVBLSTElMCMGA1UEAwwcREZOLVZlcmVpbiBHbG9iYWwgSXNzdWluZyBDQQIM
IwapvgoidmnnsEoeMIGxBgsqhkiG9w0BCRACCzGBoaCBnjCBjTELMAkGA1UEBhMCREUxRTBDBgNV
BAoMPFZlcmVpbiB6dXIgRm9lcmRlcnVuZyBlaW5lcyBEZXV0c2NoZW4gRm9yc2NodW5nc25ldHpl
cyBlLiBWLjEQMA4GA1UECwwHREZOLVBLSTElMCMGA1UEAwwcREZOLVZlcmVpbiBHbG9iYWwgSXNz
dWluZyBDQQIMIwapvgoidmnnsEoeMA0GCSqGSIb3DQEBCwUABIIBAKT4tIeev0LZtYS9bQKm8FUz
XFuIFh3TNhQwynbHdW7aarzCE2GeCqH/tb9RPjSnJ6QiW5QsHZ+IKTvoJVRT0/NGm/SGsxJy0o0h
dQ5YR4NOr/xbgny++C9/qhbJFu6c42gqX0EM1L+Mrdd4a/TAJcZcLSi+3DFHsjwUjXmE5YHb98oK
m3c1jQpdcQM9qT9gWQqt7flrdbDu1WHqcDaARkLlQlVlcepAHfX1jQPOUF7MjfypppDzJOw/bVJA
Kq8GOiDoJdigW0pUSmgq0RaKCaJyq5OGQQNnQaJb7tD5X062wyGwUq4c0mcdJELecWHS49E9YoM4
1c/CWBaO3bnGEsAAAAAAAAA=

--Apple-Mail=_F651E149-AF95-4090-A327-6294F164A91D--
