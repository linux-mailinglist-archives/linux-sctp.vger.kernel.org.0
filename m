Return-Path: <linux-sctp+bounces-1130-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKRFFykWs2mDSAAAu9opvQ
	(envelope-from <linux-sctp+bounces-1130-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Thu, 12 Mar 2026 20:38:17 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BA62782AE
	for <lists+linux-sctp@lfdr.de>; Thu, 12 Mar 2026 20:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC9E33144F97
	for <lists+linux-sctp@lfdr.de>; Thu, 12 Mar 2026 19:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E264014BF;
	Thu, 12 Mar 2026 19:33:55 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EED3AC0E2;
	Thu, 12 Mar 2026 19:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773344034; cv=none; b=j33607n42e689OLFpqcE53xFh+mXzT0DHyFuURweRJDCnHcwW3FtYJuTwAwE7ZtTqn92an8BownNrtmHLhnnlR6hLvKAuI+SoVXShgoz/FNRyMB49rWOhUxMnrt0E5LHZZe0uYfRusDdVxUM+4AJvAJQujoLYUQ8fY7Cwp76ZKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773344034; c=relaxed/simple;
	bh=VQ4I1//oujMg/wMbvtHZ1fNg62i5rEhIWcPKRohhj4U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ddy2a7nze40y2XOq6AzX5P+yK/YAMZEsZCu4is1ZBhMnJKS9vFgMZWqpirXNxVgz6pZsokw/214XhfsoPaQlvyfIqpgQ2GBgjj20XFkl4eJeH0Ugf3RmPz5wDBJf3rAKd+aMd7liJ/M4aSZTOFN9EXdHYYjti5z0jySqd1deAiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 4DE582C14A8;
	Thu, 12 Mar 2026 20:33:44 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id yCwNT8mwVvHB; Thu, 12 Mar 2026 20:33:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 8A34D2C14AA;
	Thu, 12 Mar 2026 20:33:43 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3HN7guaAFMsE; Thu, 12 Mar 2026 20:33:43 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id ABF4A2C14A6;
	Thu, 12 Mar 2026 20:33:42 +0100 (CET)
Date: Thu, 12 Mar 2026 20:33:42 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx <amd-gfx@lists.freedesktop.org>, 
	apparmor <apparmor@lists.ubuntu.com>, bpf <bpf@vger.kernel.org>, 
	ceph-devel <ceph-devel@vger.kernel.org>, cocci <cocci@inria.fr>, 
	dm-devel@lists.linux.dev, 
	DRI mailing list <dri-devel@lists.freedesktop.org>, 
	gfs2 <gfs2@lists.linux.dev>, 
	intel-gfx <intel-gfx@lists.freedesktop.org>, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>, 
	linux-bluetooth@vger.kernel.org, 
	linux-btrfs <linux-btrfs@vger.kernel.org>, 
	linux-cifs <linux-cifs@vger.kernel.org>, linux-clk@vger.kernel.org, 
	linux-erofs <linux-erofs@lists.ozlabs.org>, 
	linux-ext4 <linux-ext4@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-gpio@vger.kernel.org, 
	linux-hyperv <linux-hyperv@vger.kernel.org>, 
	linux-input@vger.kernel.org, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-leds@vger.kernel.org, 
	linux-media <linux-media@vger.kernel.org>, 
	linux-mips <linux-mips@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, linux-modules@vger.kernel.org, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-nfs <linux-nfs@vger.kernel.org>, 
	linux-omap <linux-omap@vger.kernel.org>, 
	linux-phy@lists.infradead.org, linux-pm <linux-pm@vger.kernel.org>, 
	linux-rockchip <linux-rockchip@lists.infradead.org>, 
	linux-s390 <linux-s390@vger.kernel.org>, 
	linux-scsi <linux-scsi@vger.kernel.org>, linux-sctp@vger.kernel.org, 
	LSM <linux-security-module@vger.kernel.org>, 
	linux-sh <linux-sh@vger.kernel.org>, 
	linux-sound <linux-sound@vger.kernel.org>, 
	linux-stm32 <linux-stm32@st-md-mailman.stormreply.com>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	linux-usb@vger.kernel.org, 
	linux-wireless <linux-wireless@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, ntfs3 <ntfs3@lists.linux.dev>, 
	samba-technical <samba-technical@lists.samba.org>, 
	sched-ext@lists.linux.dev, target-devel@vger.kernel.org, 
	tipc-discussion@lists.sourceforge.net, v9fs <v9fs@lists.linux.dev>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <1584421372.26258.1773344022512.JavaMail.zimbra@nod.at>
In-Reply-To: <20260310-b4-is_err_or_null-v1-48-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-48-bd63b656022d@avm.de>
Subject: Re: [PATCH 48/61] mtd: Prefer IS_ERR_OR_NULL over manual NULL check
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF148 (Linux)/8.8.12_GA_3809)
Thread-Topic: Prefer IS_ERR_OR_NULL over manual NULL check
Thread-Index: 0l8CyewQmrWlgaG6N3QgQFfukutRbA==
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1130-lists,linux-sctp=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[nod.at];
	RCVD_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-sctp];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[richard@nod.at,linux-sctp@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[56];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.954];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nod.at:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,avm.de:email]
X-Rspamd-Queue-Id: 09BA62782AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

----- Urspr=C3=BCngliche Mail -----
> Von: "Philipp Hahn" <phahn-oss@avm.de>
> -=09if (gpiomtd->nwp && !IS_ERR(gpiomtd->nwp))
> +=09if (!IS_ERR_OR_NULL(gpiomtd->nwp))

No, please don't.

This makes reading the code not easier.

Thanks,
//richard

