Return-Path: <linux-sctp+bounces-1167-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGhFK9YZ2WnfmAgAu9opvQ
	(envelope-from <linux-sctp+bounces-1167-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Fri, 10 Apr 2026 17:40:06 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4406C3D97EB
	for <lists+linux-sctp@lfdr.de>; Fri, 10 Apr 2026 17:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C4D7313139B
	for <lists+linux-sctp@lfdr.de>; Fri, 10 Apr 2026 15:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7F03E9F9B;
	Fri, 10 Apr 2026 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="VM9pR3FU"
X-Original-To: linux-sctp@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E373DE441
	for <linux-sctp@vger.kernel.org>; Fri, 10 Apr 2026 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834455; cv=none; b=YuEt5WZ47vcO8xb2uoGy9R5PYChc7cK7JFv9x0zGFdnbAEuB+dwWz+5BpflY8Ns3yArq8rQwoUB2gW7W9pvhaq456VFC7ZY8cSMOq55AolNrfDiZ7wuSbWSKNddZZcsnrM83PZczKFiYzUd4R3OWv0pSZjefdmzBt89dbTWJORw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834455; c=relaxed/simple;
	bh=2PJcapuxUWWHQgHKuYh+AB0Bg9+uWPE8WWtuj/kl/pY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tkI+88R7rYdiFPbqglB8EghO8TcWFHv63ILG43Q8KKY3dZDvBvP9BPm7s1nU6o1tCVosGN08w50lhKBu9GtuJkVdkaOOLCVY4B3M12mLpW8mpNjvLbSMdcsXXCH5N+FHThC6NUQBYUc2kQklojXWBbhW+SNok+u8WHNNrsDhpkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=VM9pR3FU; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-116-90.bstnma.fios.verizon.net [173.48.116.90])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 63AFIonm015842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 11:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1775834338; bh=eTlXD+fEi5OyNbu4TxRTwpDmEzFd2ThBwniicSqJG9M=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=VM9pR3FUqiyu4dGQLYjxtn5fwtIzfU7ySZMp0abbH18xV6/gDABRi9uB743lXz8hh
	 DLg+D58JGiw6cmfTe96qrNZsfI1LrX8CH4Z4SZsryjUI4LnJNSYnME68kmTAWN0bac
	 +APmObxjmRctPfSGmHJbriSXfrkN55pWYIbiVRfu2y0ECqpOPHSJun6K+BHM+LkVI2
	 DM7T+QYmlRWbU/sqPlO03FdXluf2F9iRmmuiDmCsbPLwL4U9izV2zs90P/AyWnNi7/
	 WJE2W3FtW9KojAgen2wKI5w3YJJGh4CS8IuF5T47bMgUta6WPQzUW9F7QaunmIRgXz
	 enYXQQPwNnobw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 0D7462E00E1; Fri, 10 Apr 2026 11:18:48 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
        bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
        dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
        gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
        intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
        kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
        sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev,
        Philipp Hahn <phahn-oss@avm.de>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH 04/61] ext4: Prefer IS_ERR_OR_NULL over manual NULL check
Date: Fri, 10 Apr 2026 11:18:40 -0400
Message-ID: <177583430870.2758959.6171961359325912353.b4-ty@b4>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310-b4-is_err_or_null-v1-4-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-4-bd63b656022d@avm.de>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1167-lists,linux-sctp=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mit.edu:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-sctp@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[56];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4406C3D97EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, 10 Mar 2026 12:48:30 +0100, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Change generated with coccinelle.

Applied, thanks!

[04/61] ext4: Prefer IS_ERR_OR_NULL over manual NULL check
        commit: 1d749e110277ce4103f27bd60d6181e52c0cc1e3

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

