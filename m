Return-Path: <linux-sctp+bounces-950-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEe/Cwv8p2mlnAAAu9opvQ
	(envelope-from <linux-sctp+bounces-950-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 04 Mar 2026 10:31:55 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7E81FD9E1
	for <lists+linux-sctp@lfdr.de>; Wed, 04 Mar 2026 10:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9417B30467EB
	for <lists+linux-sctp@lfdr.de>; Wed,  4 Mar 2026 09:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDF53542E1;
	Wed,  4 Mar 2026 09:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9sIRKFF"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FDA398901
	for <linux-sctp@vger.kernel.org>; Wed,  4 Mar 2026 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772616639; cv=none; b=NMdDDPPoGmR6jmgz8/LMSRyZI0eHemTdvy0e2p3dM7geL2bdVsbC9EZ1zBNbs0Ln5oQc23qnqwUfLrxKusutut32BTMXDECsvtgBfmc0zIumgU/XJTjJVxrbyO0PI7G+lUU3Fr8d97M4GGo6iZWH50ROZ+L9MB+FzQpR3dYuxC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772616639; c=relaxed/simple;
	bh=qyvL/iXE6+TakoKVVxVCaopqm1BpX+f7Q05dx5gBHDE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rwyo+svmMDYXiYxG8SfbGuVK6aXGevH1jQU2fvuks1qBiGTDLVxTT98v0GV3IIotCKZwnpXbdOn6YAPHchvBkI+D6Dtz7EcJTNVta4dJnO+Ei3sQYsTl5lxyzrAvrJHQFA2JsPYPJJxhHlwSUX9zwIk1f86DVgz35DIYDokR2jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9sIRKFF; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-483a233819aso64872435e9.3
        for <linux-sctp@vger.kernel.org>; Wed, 04 Mar 2026 01:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772616636; x=1773221436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUzQoESoh9/PqMSFbMpuw4Pmh5IPXiGP/qvOjxX4wwo=;
        b=b9sIRKFFaokgkSrgeWrbA/ViOpJjWP1ViLK9R1Hc1//m2coegBzgKtpFqwevCmiACZ
         C7afbaacWCHtjdaHICcRaatb9x6ZEJn6NhG6Zj9DIWESFWJ1Wfs22M1hBHSvsJT6ov0y
         u+gbatvToXFWw4Ws1z6B810aDtF2H+NtjWSzWUXjnH2Uagh4gEk5+S1nkLp8lVzxzopS
         A1lgIkzEEAlqX7ANlEMButL3162rmrsjjiFCTqL06qEr4gqfcdGAwI6S5Z1yvtqPS7rR
         QeMeyyLIZ4ZsiMHZmsjBPBW/Gjz82S/2K6mHxq88plnIdodtUPQPjzOSR2cd/SZiIcXY
         bgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772616636; x=1773221436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BUzQoESoh9/PqMSFbMpuw4Pmh5IPXiGP/qvOjxX4wwo=;
        b=rX5WqQGCOVReyTRtVckfkZ2E8qd/ze9YXXryvHsTWtdST1yv135HWoELF4dmpSTDdC
         +GyYB7XCJWxcjh6YXCkjwRFbVT3MLl6dNCbfstAg3ul/aTfsjZCUcaO+NK0e5+CXVNsR
         TjxLgxzip2lHPKu9boe/RB8OnElNOtrweT1wb/N/DjfRax7TUOAi5jqa5Bwq4vhdGuz3
         yhXfJB2ntr3Z8DJixOBMb8GVvNDva4gc+2Vt6QWm7aejYd2Eqe4BzjQtf9mUpgUf7sQ9
         /mch7ff7SCq+SsLsLejFZuAf2UKZ2favU1z2sQDlymnzj4G2vXv4BQafoIYz4u4fBz7b
         AvGA==
X-Forwarded-Encrypted: i=1; AJvYcCXOYwoyiIHrlvdfW380I/6IX7T+RW2YatlfM43efQ+mcYcU+bR9w/ZlbKN/lIZyTYks5ZzEMpzrw64F@vger.kernel.org
X-Gm-Message-State: AOJu0YwbrzyoTYowsOrrEiXob5wE9TOPT/5ZOh3Hn7WkZZSMkqIW65WD
	UKuUjekPiYx2ZAJdnSIyv6dXmBEgSMT9PASjQtnsEtHPgq9aswn80KgA
X-Gm-Gg: ATEYQzxQpw2rVlIEl1gaPDQy0GZoR4sGoTouuF8NHcj6pWAK7DM/Hzk1M/Qebe6IRW4
	F2a0oMp998yWelDlZSevot7wSgvn79ctyAxmaB973CbwCxRy1mUWyX4dG6N1s7+Xg9AP50O/DWA
	yyKTLzjCOyvpExeklZf4yayFoc0G2+Ifprpjpsvu0WqxBBOvF2S/4EL2kvyIGyh3PDWCKhHs9sx
	6Gcpwr8HuMSjWp2z4liST+3Ha4hbpdaRMnWW1lTLJLi888859CDsOEu51zOQv40gPU2vsGch17w
	y708tRmUNWMWH+SclFjptBzHI0aOjqOH8EUclFRleGpahC6j1fcb0QkVKKl55zqH/Kaew1mKlyb
	dkBi2KszItdq8efWbjMNpTjN09WzAwnbtDXEcNnXWh9qnojonVIbCXDK6Bs8odIewDskm9ZTZ+q
	jPrq4tyqjWn4NCB5/dxuQvWy2AsgbmhoMkpj+NbW014b6QIs187mYbXXEa+w3XkCMN
X-Received: by 2002:a05:600c:8b53:b0:483:498f:7963 with SMTP id 5b1f17b1804b1-4851989024emr19550785e9.26.1772616636117;
        Wed, 04 Mar 2026 01:30:36 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851884225asm38972555e9.6.2026.03.04.01.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 01:30:35 -0800 (PST)
Date: Wed, 4 Mar 2026 09:30:33 +0000
From: David Laight <david.laight.linux@gmail.com>
To: NeilBrown <neilb@ownmail.net>
Cc: "Jeff Layton" <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, fsverity@lists.linux.dev, linux-mm@kvack.org,
 netfs@lists.linux.dev, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-nilfs@vger.kernel.org, v9fs@lists.linux.dev,
 linux-afs@lists.infradead.org, autofs@vger.kernel.org,
 ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu,
 ecryptfs@vger.kernel.org, linux-mtd@lists.infradead.org,
 jfs-discussion@lists.sourceforge.net, ntfs3@lists.linux.dev,
 ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org,
 linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
 selinux@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, netdev@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-hams@vger.kernel.org,
 linux-x25@vger.kernel.org, audit@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org,
 linux-sctp@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 000/110] vfs: change inode->i_ino from unsigned long
 to u64
Message-ID: <20260304092559.554ac9a9@pumpkin>
In-Reply-To: <177260561903.7472.14075475865748618717@noble.neil.brown.name>
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org>
	<1787281.1772535332@warthog.procyon.org.uk>
	<1c28e34c7167acf4e20c3e201476504135aa44e8.camel@kernel.org>
	<177260561903.7472.14075475865748618717@noble.neil.brown.name>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CC7E81FD9E1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-950-lists,linux-sctp=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[ownmail.net];
	RCPT_COUNT_TWELVE(0.00)[46];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, 04 Mar 2026 17:26:59 +1100
NeilBrown <neilb@ownmail.net> wrote:

> On Tue, 03 Mar 2026, Jeff Layton wrote:
> > On Tue, 2026-03-03 at 10:55 +0000, David Howells wrote:  
> > > Jeff Layton <jlayton@kernel.org> wrote:
> > >   
> > > > This version splits the change up to be more bisectable. It first adds a
> > > > new kino_t typedef and a new "PRIino" macro to hold the width specifier
> > > > for format strings. The conversion is done, and then everything is
> > > > changed to remove the new macro and typedef.  
> > > 
> > > Why remove the typedef?  It might be better to keep it.
> > >   
> > 
> > Why? After this change, internel kernel inodes will be u64's -- full
> > stop. I don't see what the macro or typedef will buy us at that point.  
> 
> Implicit documentation?
> ktime_t is (now) always s64, but we still keep the typedef;
> 
> It would be cool if we could teach vsprintf to understand some new
> specifier to mean "kinode_t" or "ktime_t" etc.  But that would trigger
> gcc warnings.

A more interesting one would be something that made gcc re-write the
format with the correct 'length modifier' for the parameter.

That would save a lot of effort!

	David

> 
> NeilBrown
> 


