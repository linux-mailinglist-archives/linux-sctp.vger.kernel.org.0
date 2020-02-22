Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7529168E53
	for <lists+linux-sctp@lfdr.de>; Sat, 22 Feb 2020 11:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgBVKyT (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sat, 22 Feb 2020 05:54:19 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51566 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgBVKyS (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sat, 22 Feb 2020 05:54:18 -0500
Received: by mail-wm1-f66.google.com with SMTP id t23so4365655wmi.1
        for <linux-sctp@vger.kernel.org>; Sat, 22 Feb 2020 02:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZLo5LCvdfu3ezfBMcRotViXKw0xXJlw1RqNmTKudBwU=;
        b=Sb4rWm9fVCdHaH3rfXeEBAxWRzsH/anDqvzyGtXR6d/4wBaNXQ2I9zuWHTPKo5x+/g
         aoC+w2zos6zXBq3EKfQbfdReNufmjUEG9ynKbX0cNEvJKTnv06sTtSYO+uJk9xVsIlq+
         N9JMgeAjYaJ9yvl9O4w+xke7tjBdC0HwYXBHrQ06aqTOJhIUz7jG8+nCQhak8CKXkuta
         Dvhed9F3pSXGqd769snsYkKsLVErl8YhMWTvDT2Nc8+Q9I9s1SZDv7jRgMT011VlngsF
         DjMqrZrh5djKvCAnQSuNImBDnPS4PhCe2keLTiM55M28iIvLKFRbyNY4yTaA4FPgTp5e
         Fh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZLo5LCvdfu3ezfBMcRotViXKw0xXJlw1RqNmTKudBwU=;
        b=r7uJSBImES7TwJ7ukw95Vd+mFR/JZ+jsSkGSG1rz9HFw0CG8bI3Wb63uvFv0gmFEfE
         tkCZIWiDZH54X3Jegth442yildXEsIYwBj+fVNXT2YjEAO7gHbSO/EOgVDGXP9nan456
         7fxaJMe6+86J9zl8RV6okk/IZPho8GB8ySzREd3TSccJIGN0+pobF52z33bflTSKBBee
         +M0rbSSleTL9ma/XaztU0HmXC+aRh473Q8qhxh3U+pGSNxCM/pl9G4AdGbOTJW9A6/Bm
         GXrBMTObuwdcFEiFoUyPrVjw03EEgZL7TG+K4i4gF7KCQFx0UFEmOeyTWgR3Dw5dwO5z
         0MsQ==
X-Gm-Message-State: APjAAAXJqDUz9/5dn/HM+pGdHNylzoHsTD9+yCAHqopuFEOUvI1f9/mi
        K8C+61izvIKgM2CbSbtYnhVkcXJx1sU3fl6eH2Qk+wml6cM=
X-Google-Smtp-Source: APXvYqx2GDeT1ZG/9vqy33OeoYGQqjuWAv5hzIcHMbsUTKYJ1z8KHPliVwPwrx+oi+07zz/RLgV4ASpCIg8e6FqJqv4=
X-Received: by 2002:a1c:7712:: with SMTP id t18mr10014007wmi.32.1582368856333;
 Sat, 22 Feb 2020 02:54:16 -0800 (PST)
MIME-Version: 1.0
References: <etPan.5e4f04f9.7f1d9184.6626@csiro.au> <etPan.5e4f0735.2451de02.6626@csiro.au>
In-Reply-To: <etPan.5e4f0735.2451de02.6626@csiro.au>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Sat, 22 Feb 2020 18:55:32 +0800
Message-ID: <CADvbK_c85MCYmT08MxjszFHA-jxqKsFGsWjDdMkGFH9zDr+8bA@mail.gmail.com>
Subject: Re: Possible SCTP bug in kernel 4.9.199 and later
To:     "Craig, Daniel (CASS, Marsfield)" <Daniel.Craig@csiro.au>
Cc:     Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Fri, Feb 21, 2020 at 6:25 AM Craig, Daniel (CASS, Marsfield)
<Daniel.Craig@csiro.au> wrote:
>
> Hi,
>
> (Resending in plain HTTP mail)
>
> We=E2=80=99ve hit what seems to be a bug in a patch to SCTP in the 4.9 lo=
ngterm kernel. We are using clvm as a key part of a dual-node high availabi=
lity setup. Clvm uses DLM, which in our config (via corosync) uses SCTP as =
its underlying protocol.
>
> Since debian kernel 4.9.0-12-amd64 (based on 4.9.210) we have a problem w=
here clvm fails to start (it times out) on cluster startup because DLM appe=
ars to fail to connect, in the process spamming the kernel log with message=
s like this:
>
> Feb 20 13:05:18 hatest00 kernel: [  283.197399] dlm: connecting to 168821=
374
> Feb 20 13:05:18 hatest00 kernel: [  283.197422] dlm: connecting to 168821=
374
> Feb 20 13:05:18 hatest00 kernel: [  283.197443] dlm: connecting to 168821=
374
> Feb 20 13:05:18 hatest00 kernel: [  283.197464] dlm: connecting to 168821=
374
>
> and on the other node:
>
> Feb 20 13:05:18 hatest01 kernel: [  279.140513] dlm: connecting to 168821=
373
> Feb 20 13:05:18 hatest01 kernel: [  279.140741] dlm: connecting to 168821=
373
> Feb 20 13:05:18 hatest01 kernel: [  279.140978] dlm: connecting to 168821=
373
> Feb 20 13:05:18 hatest01 kernel: [  279.141209] dlm: connecting to 168821=
373
>
> This has the ultimate effect of causing the HA cluster to be unusable, be=
cause without clvm we have no access to the cluster=E2=80=99s shared storag=
e.
>
> The previously working debian kernel package 4.9.0-11-amd64 is based on k=
ernel version 4.9.197. I=E2=80=99ve verified that this behaviour exists in =
the vanilla kernel in addition to the debian kernel. I=E2=80=99ve also veri=
fied that it still occurs on the latest vanilla kernel in the branch - curr=
ently 4.9.214.
>
> Our initial attempts to debug the problem involved reverting all DLM patc=
hes made between 4.9.198 and 4.9.210, this had no impact. We then looked at=
 SCTP and were able to verify the problem was introduced in 4.9.199. Revert=
ing both patches (individually) to SCTP in this series seems to point to th=
e following commit as being the problematic one:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?=
h=3Dlinux-4.9.y&id=3Df8b141077a9a8fd2a7f6bae447a710a6d224b44e
>
> Please let me know if you need any more information or you=E2=80=99d like=
 me to run any tests.
Please backport this commit:

commit da3627c30d229fea1e070e984366f80a1c4d9166
Author: Gang He <ghe@suse.com>
Date:   Tue May 29 11:09:22 2018 +0800

    dlm: remove O_NONBLOCK flag in sctp_connect_to_sock
