Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 259BE73025
	for <lists+linux-sctp@lfdr.de>; Wed, 24 Jul 2019 15:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfGXNqN (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 24 Jul 2019 09:46:13 -0400
Received: from mail-wm1-f98.google.com ([209.85.128.98]:53794 "EHLO
        mail-wm1-f98.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfGXNqN (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 24 Jul 2019 09:46:13 -0400
Received: by mail-wm1-f98.google.com with SMTP id x15so41905729wmj.3
        for <linux-sctp@vger.kernel.org>; Wed, 24 Jul 2019 06:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:dkim-signature:from:content-transfer-encoding
         :mime-version:date:subject:message-id:to;
        bh=gzaXJg6nqnG2HOsIyn6AmSFpkfZ+Z9DqhaZeCbJKNcg=;
        b=TppwiKRRnmqBfv0ItTcvSETMWQKqJUb5KOQlx0Squ2sNCenX1Xv5QhJW8K9yQRLdw4
         zfvYYtUl8nF3q07Z+W0awRqjZc8gdCrrGayWLHtxk/9mpG00/eyHWsDjqkYoSbS2m8is
         J8rfEJxiN36SmGPsgVSAiCDe8MTZq2pGXenyEFvDp0pV7uPhlCdmSqXpQWhLC18efnT9
         tevhzES3gh8Qs81V7S8ozacYwuXVB1bLwkjlwLi0ON+wBhRikEc9fi/MoAdePoULREu/
         Q43PAoYCA49mO9VgFYeaRHXxbvFXtA4CU2vWW3T68AbuApNqLZzm4scpVMtR2A3dR0Oz
         yoVA==
X-Gm-Message-State: APjAAAVnzT49kmZ0UO5GzRBLMdqonVUWwxynyeQAkVMTYb0aANQXKDRF
        7VGFWfDZFldCgtEkxcQIQ46miNYZvGakj+03pvMQWBUCrNVZRStYwIe+2fVqgxdkig==
X-Google-Smtp-Source: APXvYqxJbfBqjGvgSLRsBLe+j7mIGOlvqYbbgBql2H2WmTfPHWmlSaUAJnNEZl9YH7p3Bz6f3hmBwNVNFkNv
X-Received: by 2002:a7b:c081:: with SMTP id r1mr23747891wmh.76.1563975970987;
        Wed, 24 Jul 2019 06:46:10 -0700 (PDT)
Received: from heimdall.cnix.ro (heimdall.cnix.ro. [2a03:4000:13:4e1::1])
        by smtp-relay.gmail.com with ESMTPS id f3sm298945wmb.19.2019.07.24.06.46.10
        for <linux-sctp@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 06:46:10 -0700 (PDT)
X-Relaying-Domain: cnix.ro
Received: from localhost (localhost [127.0.0.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: luci@cnix.ro)
        by heimdall.cnix.ro (Postfix) with ESMTPSA id 3DB97623E;
        Wed, 24 Jul 2019 16:46:10 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cnix.ro; s=heimdall;
        t=1563975970; bh=gzaXJg6nqnG2HOsIyn6AmSFpkfZ+Z9DqhaZeCbJKNcg=;
        h=From:Date:Subject:To:From;
        b=RxW3MGmbrhuzY8aomjxKSgke6NkFnX97eJMKF7pn6TyeNWflqauaZ9vXpDMDyy2EB
         5W8ldLYmdSysEq71nGLYChQDq69pdV7mNsBSCBJzvfNSheysMwqM9RoyVwRdZQJq8i
         ZtHtGLHXktUh+CpzDR+JB6EDe59LynfIGrUCXmEI=
From:   Luci Stanescu <luci@cnix.ro>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Date:   Wed, 24 Jul 2019 14:46:09 +0100
Subject: SCTP recvmsg MSG_TRUNC or something similar
Message-Id: <D588EC18-6A7B-4D2B-AB0A-2961A247DC3B@cnix.ro>
To:     linux-sctp@vger.kernel.org
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi,

I=E2=80=99m not sure this is the right place to ask this kind of =
question, but, having not found a better forum, I=E2=80=99m trying my =
luck. Apologies in advance if this is outside the scope of the mailing =
list.

That being said, my question is: given a successful return of recvmsg() =
for a SOCK_SEQPACKET SCTP socket, is there no stateless way to determine =
if the read data, for which the MSG_EOR flag is set, is the trailing =
=E2=80=9Cfragment=E2=80=9D of a larger record (either due to partial =
delivery or an insufficient buffer passed to a prior call to recvmsg() =
which returned with the MSG_EOR flag cleared), rather than a =E2=80=9Cfull=
=E2=80=9D message?

=46rom what I can tell, MSG_TRUNC, which would=E2=80=99ve solved my =
issue, isn=E2=80=99t implemented for SCTP. Regarding this topic, I=E2=80=99=
ve only found old discussions, including some suggestions to add =
SOCK_RDM, which never materialised.

Many thanks for your time!

Luci=
