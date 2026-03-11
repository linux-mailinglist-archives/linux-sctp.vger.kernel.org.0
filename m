Return-Path: <linux-sctp+bounces-1103-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHIJKfX0sWl7HQAAu9opvQ
	(envelope-from <linux-sctp+bounces-1103-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Thu, 12 Mar 2026 00:04:21 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DEE26B17D
	for <lists+linux-sctp@lfdr.de>; Thu, 12 Mar 2026 00:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03DD3304812C
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 23:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7693A1689;
	Wed, 11 Mar 2026 23:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="WxcdvAR4"
X-Original-To: linux-sctp@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969E039DBF5;
	Wed, 11 Mar 2026 23:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773270226; cv=none; b=AkA2Gnlxmrw7n8wlICODGs3io7QO9Oh/YDy07WP09JF/KFh9g5IxYQ17wt6vWQVzPCB+iYEQu7P3mBvtqRc+n31lnQN5NVwKohchMiBQHqmgSZE6jhjwc4hv3UUzJs1InFDBm/aIiY3ylNEkhCwq8TX0CYHFVkpY9m+PERgjhT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773270226; c=relaxed/simple;
	bh=ATo3aRyKmYSXuSYD8x/NeBUp5LJcLKbzHVpozNXQJC0=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=riWYrESCcc9KNXqP13SZYyXzR58RrYMlS+b2xha5iOXuuIp+StTrVizqL6ketCeeYmMEMoyxUK8taVuLlBt+IYJOKFEOgMITJUBE5YxvJbFyx57ukqqJFBTg7MI8yXilCszhmCyW65ADzTthRqCB0cIhFeDkNxgzAb+Zf6dy7s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=fail (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=WxcdvAR4 reason="signature verification failed"; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from monstersaurus.ideasonboard.com (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id CD91E448;
	Thu, 12 Mar 2026 00:02:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1773270149;
	bh=ATo3aRyKmYSXuSYD8x/NeBUp5LJcLKbzHVpozNXQJC0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=WxcdvAR4zphcUuTNTLXCbLGiiCOKCwemLRMbnRdmW3ARcBHAWQiYVeysDpnfCIDuk
	 B8rMCjKjDjoWJdgj4Zp0scfHxrPnr5P3xl9hFANY/wyWKZBZYHzyf2qsFxVEe9S31Y
	 m9r/HjFnopry9bsUUdk6/id/Q3d97jYK/FiMa+Qw=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260310-b4-is_err_or_null-v1-49-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-49-bd63b656022d@avm.de>
Subject: Re: [PATCH 49/61] media: Prefer IS_ERR_OR_NULL over manual NULL check
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
To: Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org,
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org,
	ceph-devel@vger.kernel.org, cocci@inria.fr, dm-devel@lists.linux.dev,
	dri-devel@lists.freedesktop.org, gfs2@lists.linux.dev,
	intel-gfx@lists.freedesktop.org, intel-wired-lan@lists.osuosl.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-phy@lists.infradead.org,
	lin@web.codeaurora.org, ux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
	sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev
Date: Wed, 11 Mar 2026 23:03:33 +0000
Message-ID: <177327021364.3167621.11851238159935183684@ping.linuxembedded.co.uk>
User-Agent: alot/0.9.1
X-Spamd-Result: default: False [3.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	R_DKIM_REJECT(1.00)[ideasonboard.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[ideasonboard.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-1103-lists,linux-sctp=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[57];
	FROM_NEQ_ENVFROM(0.00)[kieran.bingham@ideasonboard.com,linux-sctp@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[ideasonboard.com:-];
	NEURAL_HAM(-0.00)[-0.726];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,ideasonboard.com:email,ping.linuxembedded.co.uk:mid,avm.de:email]
X-Rspamd-Queue-Id: 31DEE26B17D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Quoting Philipp Hahn (2026-03-10 11:49:15)
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>=20
> Change generated with coccinelle.
>=20
> To: Shuah Khan <skhan@linuxfoundation.org>
> To: Kieran Bingham <kieran.bingham@ideasonboard.com>
> To: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-media@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  drivers/media/test-drivers/vimc/vimc-streamer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/test-drivers/vimc/vimc-streamer.c b/drivers/me=
dia/test-drivers/vimc/vimc-streamer.c
> index 15d863f97cbf96b7ca7fbf3d7b6b6ec39fcc8ae3..da5aca50bcb4990c06f28e5a8=
83eb398606991e9 100644
> --- a/drivers/media/test-drivers/vimc/vimc-streamer.c
> +++ b/drivers/media/test-drivers/vimc/vimc-streamer.c
> @@ -167,7 +167,7 @@ static int vimc_streamer_thread(void *data)
>                 for (i =3D stream->pipe_size - 1; i >=3D 0; i--) {
>                         frame =3D stream->ved_pipeline[i]->process_frame(
>                                         stream->ved_pipeline[i], frame);
> -                       if (!frame || IS_ERR(frame))
> +                       if (IS_ERR_OR_NULL(frame))

Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

>                                 break;
>                 }
>                 //wait for 60hz
>=20
> --=20
> 2.43.0
>

