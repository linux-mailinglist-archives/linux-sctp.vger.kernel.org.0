Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 078CD74A6C
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Jul 2019 11:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbfGYJxc (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 25 Jul 2019 05:53:32 -0400
Received: from mail-ed1-f98.google.com ([209.85.208.98]:35789 "EHLO
        mail-ed1-f98.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfGYJxc (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 25 Jul 2019 05:53:32 -0400
Received: by mail-ed1-f98.google.com with SMTP id w20so49630912edd.2
        for <linux-sctp@vger.kernel.org>; Thu, 25 Jul 2019 02:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:dkim-signature:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=qmfsOVljP9JybxRIQEO8xixrbA8noQ9xf1X91bmFbNA=;
        b=q4GLWkmUsESlyvTkcd1tWf1tQ5aOvx95ufCHk2e7w1cnMBAcDh6hg2LGY/o8ewwPvz
         MHwlCTvupUcKERMJV6RQD0EVuNU70LaCTH7mD4au/s11UG5//GdmhBBetg/dGlPiJZI0
         sVRaKzAs6dObuno30zCu7jMVOappptlHXRhLkfyb/Ij/ILs/pAg8KlHVM56qb+YBl6Qf
         v3HhhmaAZxWGjP6Ujb/zUQyEWLKyJfE4Ss7cYZY3+GT+pOl/ebIrx3KGa/nbplVSyyOl
         5HTGSmtRoeNYRh+UyN9LkZPGiKXqclveJcmkofaxJNCju2cZQrEc4nrOtZemdMgaVmn1
         LzAQ==
X-Gm-Message-State: APjAAAWYyiw0nsrx1SPW9c1bUQ0KcAjWsAeS2xx3UXprkVPPn4dYKc/b
        Z4IxxH570V2fdOSCPtGC8Z5cegX7XkUFv5suFYft9H//lRjMzg==
X-Google-Smtp-Source: APXvYqw4d8bLgG+9WAnfY/AjzigCTzKyE5p5ghhj5aafX0+7/qN4HjVaqdieSJQOa4im2cBXTbaNk+Obok5o
X-Received: by 2002:a05:6402:782:: with SMTP id d2mr76646985edy.80.1564048410603;
        Thu, 25 Jul 2019 02:53:30 -0700 (PDT)
Received: from heimdall.cnix.ro (heimdall.cnix.ro. [188.68.38.233])
        by smtp-relay.gmail.com with ESMTPS id q17sm123661ejn.61.2019.07.25.02.53.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 02:53:30 -0700 (PDT)
X-Relaying-Domain: cnix.ro
Received: from localhost (localhost [127.0.0.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: luci@cnix.ro)
        by heimdall.cnix.ro (Postfix) with ESMTPSA id 7DB8A1CED7;
        Thu, 25 Jul 2019 12:53:29 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cnix.ro; s=heimdall;
        t=1564048409; bh=qmfsOVljP9JybxRIQEO8xixrbA8noQ9xf1X91bmFbNA=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=gNqczH/JzwIl2YpKNLfoXTL3Vif9UKQOTI9kL+A8N3VGYiHic4xaU7FUNGTxqswbm
         bt2A5VHmk/XSdWdZswiuP5tL/AXdn/b6I9qyKOfZyS9DzjrxtODFcJeHNKoTtPcF6n
         cSwOq1e2mXYN9JvQVv6uk+ZCYRoSI3LaU7o2Whiw=
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: SCTP recvmsg MSG_TRUNC or something similar
From:   Luci Stanescu <luci@cnix.ro>
In-Reply-To: <20190725012115.GA4064@localhost.localdomain>
Date:   Thu, 25 Jul 2019 10:53:28 +0100
Cc:     linux-sctp@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <832157EB-93B2-4B69-AADF-44C251D41A4D@cnix.ro>
References: <D588EC18-6A7B-4D2B-AB0A-2961A247DC3B@cnix.ro>
 <20190725012115.GA4064@localhost.localdomain>
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi Marcelo,

Many thanks for getting back to me!

> On 25 Jul 2019, at 02:21, Marcelo Ricardo Leitner =
<marcelo.leitner@gmail.com> wrote:
>>=20
>> =46rom what I can tell, MSG_TRUNC, which would=E2=80=99ve solved my =
issue,
>> isn=E2=80=99t implemented for SCTP. Regarding this topic, I=E2=80=99ve =
only found
>=20
> Agreed, but MSG_TRUNC would cause information loss.

In my particular context, of using SCTP as a transport for an internal, =
=E2=80=9Cproprietary=E2=80=9D protocol, I know how large messages can be =
and my only intention is to efficiently discard messages which are =
deemed too large (why these messages would exist within a controlled =
environment in the first place is beyond the scope of this discussion).

Which means that, given a sufficient buffer, and, for the time being, =
ignoring partial deliveries, I=E2=80=99m comfortable discarding =
recvmsg() returns which don=E2=80=99t have MSG_EOR set; but I am still =
stuck with the trailing data and I would need to determine based on =
previous reads that this is not a complete message =E2=80=93 a flag that =
signifies =E2=80=9Cstart-of-record=E2=80=9D would have been brilliant. =
Or I can simply process them as if they were a complete message and hope =
they=E2=80=99re not validly formed.

> What about using a larger buf?

But, how large? :-)

Cheers,
Luci

