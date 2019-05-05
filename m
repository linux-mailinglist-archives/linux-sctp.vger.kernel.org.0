Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B003213FD4
	for <lists+linux-sctp@lfdr.de>; Sun,  5 May 2019 15:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfEENyq (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sun, 5 May 2019 09:54:46 -0400
Received: from mail-n.franken.de ([193.175.24.27]:57137 "EHLO drew.franken.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726397AbfEENyq (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Sun, 5 May 2019 09:54:46 -0400
Received: from [192.168.1.2] (p57BB447D.dip0.t-ipconnect.de [87.187.68.125])
        (Authenticated sender: macmic)
        by mail-n.franken.de (Postfix) with ESMTPSA id A5BB4721E280C;
        Sun,  5 May 2019 15:54:40 +0200 (CEST)
From:   Michael Tuexen <tuexen@fh-muenster.de>
Message-Id: <A0A2576C-99C4-4F2E-98CB-D70C7CE3297A@fh-muenster.de>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_424B3C84-8637-4616-AB7A-EE44160B4AF6";
        protocol="application/pkcs7-signature";
        micalg=sha-256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: Few Questions About SCTP NAT
Date:   Sun, 5 May 2019 15:54:39 +0200
In-Reply-To: <CADvbK_ea9AHeTNfd7qCqf3yDBNinyg_4K9KxwtHhp0u3kMNP7w@mail.gmail.com>
Cc:     linux-sctp@vger.kernel.org
To:     Xin Long <lucien.xin@gmail.com>
References: <CADvbK_fJyNJJ1kMpyY0K43Drx4_4_PJUQujFQXnergoOhRAKVg@mail.gmail.com>
 <CADvbK_f22Xy_ZA-Ro1wXk-0GTyPo4jr7MocvZSfdwPk3r0YWag@mail.gmail.com>
 <CADvbK_cHvYsJWg9fDKkQsnJaDoXtjr+p+NJgXiG5wtmN8cRK6g@mail.gmail.com>
 <4C7041B8-57B9-4A2C-A381-EC42BE1F168C@fh-muenster.de>
 <CADvbK_ea9AHeTNfd7qCqf3yDBNinyg_4K9KxwtHhp0u3kMNP7w@mail.gmail.com>
X-Mailer: Apple Mail (2.3445.104.8)
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=disabled version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on mail-n.franken.de
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org


--Apple-Mail=_424B3C84-8637-4616-AB7A-EE44160B4AF6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 26. Apr 2019, at 18:39, Xin Long <lucien.xin@gmail.com> wrote:
>=20
> On Fri, Apr 26, 2019 at 8:33 PM Michael Tuexen <tuexen@fh-muenster.de> =
wrote:
>>=20
>>> On 25. Apr 2019, at 13:46, Xin Long <lucien.xin@gmail.com> wrote:
>>>=20
>>> Sorry, seems I sent to the wrong email address.
>>> use tuexen@fh-muenster.de instead.
>> ... I'm typically more responsive on this address than on the one
>> I use for mailing lists...
>>>=20
>>> On Sat, Apr 20, 2019 at 6:45 PM Xin Long <lucien.xin@gmail.com> =
wrote:
>>>>=20
>>>> cc'ing linux-sctp.
>>>>=20
>>>> On Sat, Apr 20, 2019 at 4:24 PM Xin Long <lucien.xin@gmail.com> =
wrote:
>>>>>=20
>>>>> Hi, Michael,
>>>>>=20
>>>>> I'm trying to implement SCTP NAT
>>>>> (https://tools.ietf.org/html/draft-ietf-tsvwg-natsupp-12) on =
linux,
>>>>> but got some questions:
>>>>>=20
>>>>> 1.
>>>>>                       +-------+
>>>>>              /--------| NAT 1 |--------\       /--\/--\
>>>>>  +------+   /         +-------+         \     /        \    =
+--------+
>>>>>  | Host |=3D=3D=3D                             =3D=3D=3D=3D| =
Internet |=3D=3D=3D| Host B |
>>>>>  |   A  |   \         +-------+         /     \        /    =
+--------+
>>>>>  +------+    \--------| NAT 2 |--------/       \--/\--/
>>>>>                       +-------+
>>>>>=20
>>>>> In this topo, after 4 shake-hands and asconf:
>>>>>=20
>>>>>         +---------+--------+----------+--------+-----------+
>>>>>  NAT 1  |  Int    |  Int   |   Ext    |   Ext  |    Priv   |
>>>>>         |  VTag   |  Port  |   VTag   |   Port |    Addr   |
>>>>>         +---------+--------+----------+--------+-----------+
>>>>>         |  1234   |    1   |    5678  |    2   |  10.0.0.1 |
>>>>>         +---------+--------+----------+--------+-----------+
>>>>>=20
>>>>>         +---------+--------+----------+--------+-----------+
>>>>>  NAT 2  |  Int    |  Int   |   Ext    |   Ext  |    Priv   |
>>>>>         |  VTag   |  Port  |   VTag   |   Port |    Addr   |
>>>>>         +---------+--------+----------+--------+-----------+
>>>>>         |  1234   |    1   |    5678  |    2   |  10.1.0.1 |
>>>>>         +---------+--------+----------+--------+-----------+
>>>>>=20
>>>>> Now there are 1 entry on nat1 and 1 entry on nat2. If the =
connection is
>>>>> shutdown via nat1, the entry on nat1 will be deleted, right? What =
about
>>>>> the entry on nat2, when can it be deleted?
>> Deletion of state is purely timer based. This applies to NAT1 and =
NAT2.
>>>>>=20
>>>>> 2.
>>>>>                                           /--\/--\
>>>>>  +--------+              +-----+         /        \         =
+--------+
>>>>>  | Host A | <----------> | NAT | <----> | Internet | <----> | Host =
B |
>>>>>  +--------+              +-----+         \        /         =
+--------+
>>>>>                                           \--/\--/
>>>>>=20
>>>>> In this topo,  if both paths with saddr 10.0.0.1 and 10.1.0.1 go =
through
>>>>> NAT, will there be 2 entries created on this NAT after 4 =
shake-hands and
>>>>> asconf like:
>>>>>=20
>>>>>         +---------+--------+----------+--------+-----------+
>>>>>  NAT    |  Int    |  Int   |   Ext    |   Ext  |    Priv   |
>>>>>         |  VTag   |  Port  |   VTag   |   Port |    Addr   |
>>>>>         +---------+--------+----------+--------+-----------+
>>>>>         |  1234   |    1   |    5678  |    2   |  10.0.0.1 |
>>>>>         +---------+--------+----------+--------+-----------+
>>>>>         |  1234   |    1   |    5678  |    2   |  10.1.0.1 |
>>>>>         +---------+--------+----------+--------+-----------+
>>>>>=20
>>>>> or it will be handled as "Internal Port Number and Verification =
Tag
>>>>> Collisions"?
>> Which section are you referring to?
> I was looking at:
>=20
> 6.3.  Handling of Internal Port Number and Verification Tag =
Collisions:
>=20
> "two hosts in the Private-Address space want  to set up an SCTP =
association
> with the same service provided by some hosts in the Internet"
>=20
> "in this unlikely event the NAT box MUST send an ABORT chunk with the =
M-bit
> set if the collision is triggered by an INIT or INIT-ACK chunk or send =
an
> ERROR chunk with the M-bit set if the collision is triggered by an =
ASCONF
> chunk"
>=20
> Does it mean:
> Users will fail to add the 2nd path by ASCONF chunk on the same NAT as
> the 1st path? (if these 2 paths for one asoc go through the same one =
NAT,
> NOT two different NATs).
>=20
> like:
>                                                  +--------+
>                                  /--\/--\      /-|Router 1| \
>   +------+         +-----+      /        \    /  +--------+  \ =
+------+
>   | Host | <-----> | NAT | <-> | Internet | =3D=3D                =3D| =
Host |
>   |   A  |         +-----+      \        /    \  +--------+  / |   B  =
|
>   +------+                       \--/\--/      \-|Router 2|-/  =
+------+
>=20
> (10.0.0.1, 10.1.0.1)                             (203.0.113.1, =
203.0.113.129)
>=20
>=20
> After 4 shake-hands by 10.0.0.1:1 ---> 203.0.113.1:2:
>=20
>          +---------+--------+----------+--------+-----------+
>   NAT    |  Int    |  Int   |   Ext    |   Ext  |    Priv   |
>          |  VTag   |  Port  |   VTag   |   Port |    Addr   |
>          +---------+--------+----------+--------+-----------+
>          |  1234   |    1   |    5678  |    2   |  10.0.0.1 |
>          +---------+--------+----------+--------+-----------+
>=20
> then the user wants to add the 2nd path, which will also go this NAT:
>=20
>   ASCONF [ADD-IP=3D0.0.0.0, INT-VTag=3D1234, Ext-VTag =3D 5678]
>   10.1.0.1:1 --------> 203.0.113.129:2
>            Ext-VTag =3D 5678
>=20
> What will happen on this NAT?
>=20
> please let me know if it's still unclear. Thanks.
Now it is clear to me what you are referring to.

Based on the remote vtag we could detect that this belongs to the =
existing
association.
But what would you gain? We assume that the NAT box has a single public
address. How should the NAT box map an incoming packet to one of the =
private
addresses. This selection is normally done by Host B.

Best regards
Michael
>=20
>>>>>=20
>>>>> 3.
>>>>> For multipath, each entry for one path should maintain a 'state', =
like
>>>>> closed, established, cookie-echo etc, right?  If they belong to a =
same
>>>>> association, especially when they're on different nats, how do we =
keep
>>>>> each entry's state consistent? or they don't have to be =
consistent?
>> You don't need such a state as long as you delete state purely timer =
based.
>>>>>=20
>>>>> Thanks.
>>=20


--Apple-Mail=_424B3C84-8637-4616-AB7A-EE44160B4AF6
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEJAw
ggTVMIIDvaADAgECAghQTsb1PRG0ZDANBgkqhkiG9w0BAQsFADBxMQswCQYDVQQGEwJERTEcMBoG
A1UEChMTRGV1dHNjaGUgVGVsZWtvbSBBRzEfMB0GA1UECxMWVC1UZWxlU2VjIFRydXN0IENlbnRl
cjEjMCEGA1UEAxMaRGV1dHNjaGUgVGVsZWtvbSBSb290IENBIDIwHhcNMTQwNzIyMTIwODI2WhcN
MTkwNzA5MjM1OTAwWjBaMQswCQYDVQQGEwJERTETMBEGA1UEChMKREZOLVZlcmVpbjEQMA4GA1UE
CxMHREZOLVBLSTEkMCIGA1UEAxMbREZOLVZlcmVpbiBQQ0EgR2xvYmFsIC0gRzAxMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA6ZvDZ4X5Da71jVTDllA1PWLpbkztlNcAW5UidNQg6zSP
1uzAMQQLmYHiphTSUqAoI4SLdIkEXlvg4njBeMsWyyg1OXstkEXQ7aAAeny/Sg4bAMOG6VwrMRF7
DPOCJEOMHDiLamgAmu7cT3ir0sYTm3at7t4m6O8Br3QPwQmi9mvOvdPNFDBP9eXjpMhim4IaAycw
DQJlYE3t0QkjKpY1WCfTdsZxtpAdxO3/NYZ9bzOz2w/FEcKKg6GUXUFr2NIQ9Uz9ylGs2b3vkoO7
2uuLFlZWQ8/h1RM9ph8nMM1JVNvJEzSacXXFbOqnC5j5IZ0nrz6jOTlIaoytyZn7wxLyvQIDAQAB
o4IBhjCCAYIwDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBRJt8bP6D0ff+pEexMp9/EKcD7eZDAf
BgNVHSMEGDAWgBQxw3kbuvVT1xfgiXotF2wKsyudMzASBgNVHRMBAf8ECDAGAQH/AgECMGIGA1Ud
IARbMFkwEQYPKwYBBAGBrSGCLAEBBAICMBEGDysGAQQBga0hgiwBAQQDADARBg8rBgEEAYGtIYIs
AQEEAwEwDwYNKwYBBAGBrSGCLAEBBDANBgsrBgEEAYGtIYIsHjA+BgNVHR8ENzA1MDOgMaAvhi1o
dHRwOi8vcGtpMDMzNi50ZWxlc2VjLmRlL3JsL0RUX1JPT1RfQ0FfMi5jcmwweAYIKwYBBQUHAQEE
bDBqMCwGCCsGAQUFBzABhiBodHRwOi8vb2NzcDAzMzYudGVsZXNlYy5kZS9vY3NwcjA6BggrBgEF
BQcwAoYuaHR0cDovL3BraTAzMzYudGVsZXNlYy5kZS9jcnQvRFRfUk9PVF9DQV8yLmNlcjANBgkq
hkiG9w0BAQsFAAOCAQEAYyAo/ZwhhnK+OUZZOTIlvKkBmw3Myn1BnIZtCm4ssxNZdbEzkhthJxb/
w7LVNYL7hCoBSb1mu2YvssIGXW4/buMBWlvKQ2NclbbhMacf1QdfTeZlgk4y+cN8ekvNTVx07iHy
dQLsUj7SyWrTkCNuSWc1vn9NVqTszC/Pt6GXqHI+ybxA1lqkCD3WvILDt7cyjrEsjmpttzUCGc/1
OURYY6ckABCwu/xOr24vOLulV0k/2G5QbyyXltwdRpplic+uzPLl2Z9Tsz6hL5Kp2AvGhB8Exuse
6J99tXulAvEkxSRjETTMWpMgKnmIOiVCkKllO3yG0xIVIyn8LNrMOVtUFzCCBaIwggSKoAMCAQIC
BxekJKEJSDMwDQYJKoZIhvcNAQELBQAwWjELMAkGA1UEBhMCREUxEzARBgNVBAoTCkRGTi1WZXJl
aW4xEDAOBgNVBAsTB0RGTi1QS0kxJDAiBgNVBAMTG0RGTi1WZXJlaW4gUENBIEdsb2JhbCAtIEcw
MTAeFw0xNDA1MjcxNDU0MDlaFw0xOTA3MDkyMzU5MDBaMIHGMQswCQYDVQQGEwJERTEcMBoGA1UE
CBMTTm9yZHJoZWluLVdlc3RmYWxlbjERMA8GA1UEBxMITXVlbnN0ZXIxIDAeBgNVBAoTF0ZhY2ho
b2Noc2NodWxlIE11ZW5zdGVyMSMwIQYDVQQLExpEYXRlbnZlcmFyYmVpdHVuZ3N6ZW50cmFsZTEd
MBsGA1UEAxMURkggTXVlbnN0ZXIgQ0EgLSBHMDExIDAeBgkqhkiG9w0BCQEWEWNhQGZoLW11ZW5z
dGVyLmRlMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuHlsrvBs7CL9IqMH9r//QU9E
pghTV/3skHuQZ3DpNY+lyJWOW5zbtUubgXt7lYHpIE4d4CclTZWqCHwoAI6gqzSSGjUKuX6/0ui/
LhXmlDvCBfwuER+T+3/R59hlLnhI5iYYPQiNywQIa3wJhBLTZrlXw8nDdjI54MAzcVDUX7l21sbo
ZIA6idM7SXmshxoRQ6xsfPHskrceNMcvtHNDhVnVscwRUJQUR55fs0X7Y93PasugWPv3xmgNr1da
Cq94eV+nslNU/GJaT9TQ3uG8pagLXl9NbDNkHIrvFAD5zXO0m/d00I4QhUVQyEtwnTegDqcM+WFh
JXensgnZhWe6bwIDAQABo4IB/jCCAfowEgYDVR0TAQH/BAgwBgEB/wIBATAOBgNVHQ8BAf8EBAMC
AQYwEQYDVR0gBAowCDAGBgRVHSAAMB0GA1UdDgQWBBQK81u85DGA1jVCiabTw8833tHf1zAfBgNV
HSMEGDAWgBRJt8bP6D0ff+pEexMp9/EKcD7eZDAcBgNVHREEFTATgRFjYUBmaC1tdWVuc3Rlci5k
ZTCBiAYDVR0fBIGAMH4wPaA7oDmGN2h0dHA6Ly9jZHAxLnBjYS5kZm4uZGUvZ2xvYmFsLXJvb3Qt
Y2EvcHViL2NybC9jYWNybC5jcmwwPaA7oDmGN2h0dHA6Ly9jZHAyLnBjYS5kZm4uZGUvZ2xvYmFs
LXJvb3QtY2EvcHViL2NybC9jYWNybC5jcmwwgdcGCCsGAQUFBwEBBIHKMIHHMDMGCCsGAQUFBzAB
hidodHRwOi8vb2NzcC5wY2EuZGZuLmRlL09DU1AtU2VydmVyL09DU1AwRwYIKwYBBQUHMAKGO2h0
dHA6Ly9jZHAxLnBjYS5kZm4uZGUvZ2xvYmFsLXJvb3QtY2EvcHViL2NhY2VydC9jYWNlcnQuY3J0
MEcGCCsGAQUFBzAChjtodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWNhL3B1Yi9j
YWNlcnQvY2FjZXJ0LmNydDANBgkqhkiG9w0BAQsFAAOCAQEA3kcDNdZKb7kSD7s1ly2qa/2QbQe+
ld3LhZeOcfysdLtN8oweBmgT3MYoZ+D9c+SoUWJAwTKPB15DoGy+fWhelXTpQrqxIGb4ISr1JCjg
slnmMUva0xjwZGxojZ9gE1bi18xfKw3+dMpwCLt6LbLTjr/tyH6otacwr2tZzuuJIUAORnefwTcr
vmB21n/BEQH/ZXruWu8lSO3L9YAmQB6ViaZFCpn2sMmOLACdoWxmUQb3QAjsa327jHUjsz53k9q5
Zrx/g+zOg5s1Wmy2JOlLQMUIZXXf0/6rB5Fr2llx7dBG/Uk7NhZdNy7OzNzci0C4Wnkd8rDVEWHG
hH2gfpcTfjCCBg0wggT1oAMCAQICBxuZiHQ3saMwDQYJKoZIhvcNAQELBQAwgcYxCzAJBgNVBAYT
AkRFMRwwGgYDVQQIExNOb3JkcmhlaW4tV2VzdGZhbGVuMREwDwYDVQQHEwhNdWVuc3RlcjEgMB4G
A1UEChMXRmFjaGhvY2hzY2h1bGUgTXVlbnN0ZXIxIzAhBgNVBAsTGkRhdGVudmVyYXJiZWl0dW5n
c3plbnRyYWxlMR0wGwYDVQQDExRGSCBNdWVuc3RlciBDQSAtIEcwMTEgMB4GCSqGSIb3DQEJARYR
Y2FAZmgtbXVlbnN0ZXIuZGUwHhcNMTYwNzA0MDcwNjEzWhcNMTkwNzA0MDcwNjEzWjB8MQswCQYD
VQQGEwJERTEgMB4GA1UECgwXRmFjaGhvY2hzY2h1bGUgTXVlbnN0ZXIxMjAwBgNVBAsMKUZhY2hi
ZXJlaWNoIEVsZWt0cm90ZWNobmlrIHVuZCBJbmZvcm1hdGlrMRcwFQYDVQQDDA5NaWNoYWVsIFR1
ZXhlbjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMyaGlBt2ZtuF8QP8zYNrGxXC+es
PMajIPl+hu1LGHnN2BJ3J5ZMN44BOZw3n6LO1FaAgO8D4xU4/AELecX6VxJZ2zOOSD8uTYO4OnUu
24hkjFUQAj13tT644AKUQMMBpgj7wC52V5Jij+mZX/t1S38/WFiCGnirt4xTNi5OmN4K+VNZfG4x
0msDqFjJX70rF1y09/Mylu1M/Y0tu/I9DqhwDQT4LBOvyyaAlhSJ8Jb8m8YTt5xlOzrXlBmj4pKs
74y7C2IKRw4tFozGX1cf1LVEs2eBCb5iUwXrlcMipwm62sJ38GD00EOlRNTpAM5rDAcgWxMCffek
bRv/01whtOkCAwEAAaOCAkcwggJDMEAGA1UdIAQ5MDcwEQYPKwYBBAGBrSGCLAEBBAMFMBEGDysG
AQQBga0hgiwCAQQDATAPBg0rBgEEAYGtIYIsAQEEMAkGA1UdEwQCMAAwDgYDVR0PAQH/BAQDAgXg
MB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDAdBgNVHQ4EFgQU0B2vaoSoEmYAggD04WZF
2hGif3UwHwYDVR0jBBgwFoAUCvNbvOQxgNY1Qomm08PPN97R39cwIAYDVR0RBBkwF4EVdHVleGVu
QGZoLW11ZW5zdGVyLmRlMIGIBgNVHR8EgYAwfjA9oDugOYY3aHR0cDovL2NkcDEucGNhLmRmbi5k
ZS9maC1tdWVuc3Rlci1jYS9wdWIvY3JsL2NhY3JsLmNybDA9oDugOYY3aHR0cDovL2NkcDIucGNh
LmRmbi5kZS9maC1tdWVuc3Rlci1jYS9wdWIvY3JsL2NhY3JsLmNybDCB1wYIKwYBBQUHAQEEgcow
gccwMwYIKwYBBQUHMAGGJ2h0dHA6Ly9vY3NwLnBjYS5kZm4uZGUvT0NTUC1TZXJ2ZXIvT0NTUDBH
BggrBgEFBQcwAoY7aHR0cDovL2NkcDEucGNhLmRmbi5kZS9maC1tdWVuc3Rlci1jYS9wdWIvY2Fj
ZXJ0L2NhY2VydC5jcnQwRwYIKwYBBQUHMAKGO2h0dHA6Ly9jZHAyLnBjYS5kZm4uZGUvZmgtbXVl
bnN0ZXItY2EvcHViL2NhY2VydC9jYWNlcnQuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQBI9v+seJM6
AlSIrmmpopz6zh8QAsqGLJkkY2D0KYFucUY/xZaJTtZxvmWddbKk2903Qhg+vZKOf87PHhip7/4t
FSwhxYNSS36WsRJTeUa0f3KkSa28yrIRfWlJATgxfL5X/QQnopjCt34n4221kcsR7LHxBAn37ow+
/2L7WjWDDuOkaM9/ZSCtrN+yFRat1eUVs1Hk7sKT/bfJTsYqzovXitjmCP3YdB40dkuQ6/ZzEdXT
bpa4c45RcRnPqKXnxknK0UfRHNHqk15W7dUPVMzSGFUvjhmWPP2wW6a8F1U5sEqfHcoBFC5CGjGy
7Gk2luk3obi/KLrDyZC+dkjhDYEpMYIEOTCCBDUCAQEwgdIwgcYxCzAJBgNVBAYTAkRFMRwwGgYD
VQQIExNOb3JkcmhlaW4tV2VzdGZhbGVuMREwDwYDVQQHEwhNdWVuc3RlcjEgMB4GA1UEChMXRmFj
aGhvY2hzY2h1bGUgTXVlbnN0ZXIxIzAhBgNVBAsTGkRhdGVudmVyYXJiZWl0dW5nc3plbnRyYWxl
MR0wGwYDVQQDExRGSCBNdWVuc3RlciBDQSAtIEcwMTEgMB4GCSqGSIb3DQEJARYRY2FAZmgtbXVl
bnN0ZXIuZGUCBxuZiHQ3saMwDQYJYIZIAWUDBAIBBQCgggI3MBgGCSqGSIb3DQEJAzELBgkqhkiG
9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDUwNTEzNTQzOVowLwYJKoZIhvcNAQkEMSIEIJ4x2BLG
yhE+XPXQKZIEJ6gC9f0pK7oqcJ5EARisq9zZMIHjBgkrBgEEAYI3EAQxgdUwgdIwgcYxCzAJBgNV
BAYTAkRFMRwwGgYDVQQIExNOb3JkcmhlaW4tV2VzdGZhbGVuMREwDwYDVQQHEwhNdWVuc3RlcjEg
MB4GA1UEChMXRmFjaGhvY2hzY2h1bGUgTXVlbnN0ZXIxIzAhBgNVBAsTGkRhdGVudmVyYXJiZWl0
dW5nc3plbnRyYWxlMR0wGwYDVQQDExRGSCBNdWVuc3RlciBDQSAtIEcwMTEgMB4GCSqGSIb3DQEJ
ARYRY2FAZmgtbXVlbnN0ZXIuZGUCBxuZiHQ3saMwgeUGCyqGSIb3DQEJEAILMYHVoIHSMIHGMQsw
CQYDVQQGEwJERTEcMBoGA1UECBMTTm9yZHJoZWluLVdlc3RmYWxlbjERMA8GA1UEBxMITXVlbnN0
ZXIxIDAeBgNVBAoTF0ZhY2hob2Noc2NodWxlIE11ZW5zdGVyMSMwIQYDVQQLExpEYXRlbnZlcmFy
YmVpdHVuZ3N6ZW50cmFsZTEdMBsGA1UEAxMURkggTXVlbnN0ZXIgQ0EgLSBHMDExIDAeBgkqhkiG
9w0BCQEWEWNhQGZoLW11ZW5zdGVyLmRlAgcbmYh0N7GjMA0GCSqGSIb3DQEBAQUABIIBAGyIOszI
Pf+PigqhH2AjEiRdAlDx3UG9TjeqrITspoWFj9tn8KEYIIX8wiciBcwwvfCSyR3VPEZ4w0zFJJlI
7eJXpcg0eG7HCepQ3hC3J7qjhK+9w43utz1/DMUNPeK46/mVEw+BoG57XYYx+lQjPBigtdsdPvW7
aKwmiGP+y71pAuOzBcJxQo+O+XqM5yCkYpOUaE7o6rlOisHV+qceQ+AmD8gkBAC7innzTpgy3k/v
nmlqwDDFBENl0MFOEE0nPOFTMBKYmNKm24SuElNbsay+WeRuYKc8WZg0ufRU4GWC48uJXTFShXZu
FuaFjRpdtEacVitCKpnheZWmCCzc/DoAAAAAAAA=
--Apple-Mail=_424B3C84-8637-4616-AB7A-EE44160B4AF6--
