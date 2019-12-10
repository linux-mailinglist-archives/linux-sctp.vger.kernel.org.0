Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 753C0118EB2
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Dec 2019 18:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfLJRMr (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 10 Dec 2019 12:12:47 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:44203 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbfLJRMr (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 10 Dec 2019 12:12:47 -0500
Received: by mail-pj1-f65.google.com with SMTP id w5so7641653pjh.11
        for <linux-sctp@vger.kernel.org>; Tue, 10 Dec 2019 09:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=ZD+wd55MbpiKBwOs4hW8gl6L+aU37IccOqDX3dd5NyE=;
        b=BZ92BIwWtDXhF4F+dgkNcGmqzQ0hi5vM6sId4W+ibp5wp0KptxFiuPyTYn3qC6NsbD
         alWP4GdCyylPdtkSfbJuR0i22bYHwBQHZCG9lK0ow+LTh9KrD6/L1olF8qp//GZlkd6T
         DVK9+HLGig4PTtTS0hXmThBTpl5A0aJrxentxtFoSBu3Mvmjyc5+6yBmg9UsUo6WKplh
         Gat1l7XuudmE6JYj0QuQPj3mmeWtKrm1CNB4n4/evBMIWnhBW+qgHm4LsFe6B2L30lG0
         HSn3noJi+HSib2xpP7rz1RwD4Q80gMjHHPmaCnOvyZbWs7r2mDlSr0q75PGkpXnYbj4j
         lMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=ZD+wd55MbpiKBwOs4hW8gl6L+aU37IccOqDX3dd5NyE=;
        b=cFQ8ZpQ7cPakte4N3F4x6vkuScchmapz0MpqP5/ul6KCL3oBqnW9a/VgGG2VS6ojKj
         /DvHdQlNNn4QDoE24pfJm7k0y48x41KBHZqd6xKwfkN1q34blcMMcZfmYornJmOJ5NhV
         mqwp1VambFFjlc2SjaoAmfwpjFy23vQqKbzndORxDsDWpzF+60pjOjrbaDz+tO9vdpdl
         GDJ1V+W4IlhQIRpkvPPG+VItXDJeGX5M/61WvM2LOLdl1fMna3ByJvs+cZelOeM6Kfe0
         5yuMmhgei6YuqV+VJ2qFo84bbsGnprvT81EoVVmm3jZHDuJ+05ijbccp4ItoefMt+n+m
         QDUw==
X-Gm-Message-State: APjAAAXl3Mg0He+Qu5wMjT3qNwvi1+OMmcqMvcNxQFnPOdFvrSQ6Xfg8
        jYGadb7382rp1PlETyT4ZUC7og==
X-Google-Smtp-Source: APXvYqyF6W66BMTxnAytzEXlBaKoQ91qch57tqY3e1dFG1KP9NPaSBofk8zYXzxZZf4hUrHOYFO4NQ==
X-Received: by 2002:a17:90a:a416:: with SMTP id y22mr6670085pjp.114.1575997966443;
        Tue, 10 Dec 2019 09:12:46 -0800 (PST)
Received: from cakuba.netronome.com ([2601:646:8e00:e18::3])
        by smtp.gmail.com with ESMTPSA id z4sm4077112pfn.42.2019.12.10.09.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 09:12:46 -0800 (PST)
Date:   Tue, 10 Dec 2019 09:12:41 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     subashab@codeaurora.org
Cc:     Maciej =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?= <zenczykowski@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Linux Network Development Mailing List 
        <netdev@vger.kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Sean Tranchetti <stranche@codeaurora.org>,
        Eric Dumazet <edumazet@google.com>,
        Linux SCTP <linux-sctp@vger.kernel.org>
Subject: Re: [PATCH v2] net: introduce ip_local_unbindable_ports sysctl
Message-ID: <20191210091241.0c6df09e@cakuba.netronome.com>
In-Reply-To: <0101016eee9bf9b5-f5615781-f0a6-41c4-8e9d-ed694eccf07c-000000@us-west-2.amazonses.com>
References: <CAHo-OowKQPQj9UhjCND5SmTOergBXMHtEctJA_T0SKLO5yebSg@mail.gmail.com>
        <20191209224530.156283-1-zenczykowski@gmail.com>
        <20191209154216.7e19e0c0@cakuba.netronome.com>
        <CANP3RGe8zqa2V-PBjvACAJa2Hrd8z7BXUkks0KCrAtyeDjbsYw@mail.gmail.com>
        <20191209161835.7c455fc0@cakuba.netronome.com>
        <0101016eee9bf9b5-f5615781-f0a6-41c4-8e9d-ed694eccf07c-000000@us-west-2.amazonses.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, 10 Dec 2019 07:00:29 +0000, subashab@codeaurora.org wrote:
> > Okay, that's what I was suspecting.  It'd be great if the real
> > motivation for a patch was spelled out in the commit message :/
> > 
> > So some SoCs which run non-vanilla kernels require hacks to steal
> > ports from the networking stack for use by proprietary firmware.
> > 
> > I don't see how merging this patch benefits the community.
> 
> This is just a transparent proxy scenario though.
> We block the specific ports so that there is no unrelated traffic
> belonging to host proxied here incorrectly.

It's a form of one, agreed, although let's be honest - someone reading
the transparent proxy use case in the commit message will not think of
a complex AP scenario, but rather of a locally configured transparent
proxy with IPtables or sockets or such.
