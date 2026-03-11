Return-Path: <linux-sctp+bounces-1102-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEYREqCGsWm4DAAAu9opvQ
	(envelope-from <linux-sctp+bounces-1102-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 16:13:36 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFD22662CC
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 16:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3B123035AB9
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 15:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C803DE421;
	Wed, 11 Mar 2026 15:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Wag9Fxf+"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F6C34752D;
	Wed, 11 Mar 2026 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773241979; cv=none; b=mr0dKXmazZhSx3bxUaqxllMS/W5d/CNxvBaMYmoODts+hQ4ZXfJfJDN8Lpmoy9g53yN/FpDQ41R9SrVvxw5/pAKxPAxQGeixp/hCd/GBI+w6jiUkd0V+9G4Wa37yeM692V+gGHhxAZIKFQFDbWPPASfKWbCe9fhEc1peE9Oobyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773241979; c=relaxed/simple;
	bh=8xayem6yt0HtfhsQlYY0bHMXVNy1I+u8tIW/Rzn2tYE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=CvDaTH7uyxAjzVgKz3WLB6p8+McJiXjiIe5Lm0KDItbAkxSeYyLfgswpkJoKVQkTHqZ933ifHb3iQKN0iXV0ZCaIe/p0jbgcAxLmlXIbKb8yDv9ASGuMv6NeBdLSpzG9nLDAOMOlrBNmE+tbtbbyu4VgSfY5VA/mOi/Vy8a6+bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Wag9Fxf+; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1773241960; x=1773846760; i=markus.elfring@web.de;
	bh=giiOm4nN20bJPCHKicALa9KbdO4HtuSxDT6eKFGA2mo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Wag9Fxf+yNYQPXsTRyON3wRt6746M7liQFpZpr6olBI3Hroz514SMRate1mi9Xg/
	 MIASsdEYNcunoz8/0486PBcCtmiUbXpXZk7SZ9UfEjg2yZ/tPzswVOTPVBMcMOZI0
	 P5tpvgiKmN/AWRSyt4QzAOeFSzOnPlGV7COlz4Px5LChMrnWVtTVF6O0hgI7HspJ9
	 ZFokJK/ysEIyBkMx8vWGA+V0bsSD1FiKNQpHbXMbvGQ3/XnE4gJZFGitvxFp9Ukqq
	 G2o9A+gT473BGTVzhrJiV0v2XUcnMqFfYGkufDQuk2aN8veffUebr4e9kMFhtnu0/
	 59bsB5DtXuFN3mqFBA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9cHJ-1vWLef0wrt-00vzxd; Wed, 11
 Mar 2026 16:12:40 +0100
Message-ID: <e6145c17-64ce-494e-a41a-c847df3d999e@web.de>
Date: Wed, 11 Mar 2026 16:12:34 +0100
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Philipp Hahn <phahn-oss@avm.de>, cocci@inria.fr,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, dm-devel@lists.linux.dev,
 dri-devel@lists.freedesktop.org, gfs2@lists.linux.dev,
 intel-gfx@lists.freedesktop.org, intel-wired-lan@lists.osuosl.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org,
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
 LKML <linux-kernel@vger.kernel.org>
References: <20260310-b4-is_err_or_null-v1-1-bd63b656022d@avm.de>
Subject: Re: [PATCH 01/61] Coccinelle: Prefer IS_ERR_OR_NULL over manual NULL
 check
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-1-bd63b656022d@avm.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8uNlJJTAs0E3eVrueF6w+kamgZld8V5k307BMa2qc/KwhoVrne3
 cPN5KceT1D2i5YOSNggwsPxOs655cWyte1CKlNlBLyuH93VGvstvy+ggV5GDmk4PUMu8Iwj
 lIBpLLqKBgo7uQxQM9uBZQLnvS5wa1t6ITQ23zK6Z5KinOA9Ud5Ss1etUILA/92IsKQJLWt
 MbIOhZYtTIg4ZGnA6bYYw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JCtAJ/zNjOI=;sDWY82KXUVoSud92r84ZXuFAtv9
 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
 tJ2F8GMFz7+S2uTh+G9X
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1102-lists,linux-sctp=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[web.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[web.de];
	RCPT_COUNT_GT_50(0.00)[56];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,linux-sctp@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[linux-sctp];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wikipedia.org:url]
X-Rspamd-Queue-Id: DFFD22662CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

=E2=80=A6
> +// Confidence: High

Some contributors presented discerning comments for this change approach.
Thus I became also curious how much they can eventually be taken better in=
to account
by the means of the semantic patch language (Coccinelle software).

=E2=80=A6
+@p1 depends on patch@
+expression E;
+@@
+(
> +-	E !=3D NULL && !IS_ERR(E)
> ++	!IS_ERR_OR_NULL(E)
> +|
> +-	E =3D=3D NULL || IS_ERR(E)
> ++	IS_ERR_OR_NULL(E)
> +|
> +-	!IS_ERR(E) && E !=3D NULL
> ++	!IS_ERR_OR_NULL(E)
> +|
> +-	IS_ERR(E) || E =3D=3D NULL
> ++	IS_ERR_OR_NULL(E)
> +)

Several detected expressions should refer to return values from function c=
alls.
https://en.wikipedia.org/wiki/Return_statement

* Do any development challenges hinder still the determination of correspo=
nding
  failure predicates?

* How will interests evolve to improve data processing any further for suc=
h
  use cases?


Regards,
Markus

